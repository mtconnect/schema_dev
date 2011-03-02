
require 'set'

INF = 0xFFFFFFFF

class Schema
  module Standards
    def all_standards(fill = false)
      if !@standards.empty?
        @schema.standards.map { |s| [s, @standards[s]] }
      elsif fill
        Array.new(@schema.standards.length)
      else
        []
      end
    end

    def standards_header
      @schema.standards
    end
    
    def standards(stands)
      stands.keys.each { |s| @schema.add_standard(s) }
      @standards.merge! stands
    end
  end
  
  attr_reader :packages, :derived, :importing
  attr_accessor :top, :namespace, :urn, :license, :version, :importing
  
  def initialize(script)
    @importing = false
    @packages = []
    @urn = ''
    @types = []
    @imports = []
    @type_map = { }
    @derived = Set.new
    @top = nil
    @license = nil
    @namespace = 'ns'
    @standards = Set.new
    instance_eval script, 'Top'
  end

  def load(file)
    file = file + '.msd' unless file =~ /\.[a-z]+$/
    instance_eval(File.read(file), file)
  end

  def derived?(type)
    @derived.member?(type)
  end
  
  def type(name, annotation, parent = 'string', attr = false, &block)
    BasicType.new(self, name, annotation, parent, attr, &block)
  end
  
  def attr(name, annotation, parent = 'string', attr = true, &block)
    BasicType.new(self, name, annotation, parent, attr, &block)
  end
  
  def enum(name, annotation, parent = 'string', attr = true, &block)
    ControlledVocabulary.new(self, name, annotation, parent, attr, &block)
  end
  
  def package(name, annotation, &block)
    @packages << Package.new(self, name, annotation, &block)
  end
  
  # Import another schema
  def import(name, location)
    @imports << ImportedSchema.new(self, name, location)
  end

  def add_type(name, type)
    @types << type
    @type_map[name] = type
  end

  def types
    @types
  end

  def type(name)
    @type_map[name]
  end
  
  def check_type(name)
    raise "Cannot resolve type #{name}" unless @type_map[name]
  end

  def standards
    unless defined? @ordered_standards
      @ordered_standards = @standards.to_a.map { |s| s.to_s }.sort.map { |s| s.to_sym }
    end
    @ordered_standards
  end

  def add_standard(stand)
    @standards << stand
  end
  
  class ImportedSchema
    attr_accessor :namespace, :urn, :license, :version, :top
    attr_reader :location
    
    undef :load
    undef :type
    
    def initialize(schema, file, location)
      old_importing, schema.importing = schema.importing, self
      @schema = schema
      @location = location
      file = file + '.msd' unless file =~ /\.[a-z]+$/
      puts "Importing file: #{file}"
      Dir.chdir(File.dirname(file)) do
        instance_eval(File.read(File.basename(file)), file)
      end
      schema.importing = old_importing
    end
        
    # Forward all other methods accept for the settings to schema
    def method_missing(method, *args, &block)
      @schema.send(method, *args, &block)
    end
  end
  
  class Type
    attr_reader :name, :parent, :imported
    attr_reader :annotation, :attr
    attr_accessor :version

    include Standards

    def initialize(schema, name, annotation, parent = nil)
      @name, @annotation, @parent = name, annotation, parent
      @schema = schema
      @attr = false
      @standards = { }
      @schema.add_type(name, self)
      @imported = schema.importing
    end
    
    def resolve
    end
    
    def build_hierarchy
    end
  end

  class BasicType < Type
    attr_reader :annotation, :pattern, :facet, :attr

    def initialize(schema, name, annotation, parent = 'string', attr = true, &block)
      super(schema, name, annotation, parent)
      @annotation, @attr = annotation, attr
      instance_eval &block if block
    end

    def facet(value)
      @facet = value
    end

    def pattern(value)
      @pattern = value
    end
  end

  class ControlledVocabulary < Type
    attr_reader :values, :attr, :extensible
    
    class Value
      attr_reader :name, :annotation
      include Standards
      
      def initialize(schema, name, annotation, &block)
        @schema, @name, @annotation = schema, name, annotation
        @standards = { }
        instance_eval &block if block
      end
    end
    
    def initialize(schema, name, annotation, parent = 'enum', attr = true, &block)
      super(schema, name, annotation, parent)
      @name, @annotation, @parent, @attr = name, annotation, parent, attr
      @values = []
      @extensible = false
      instance_eval &block
    end

    def extensible(type)
      @extensible = type
    end

    def value(name, annotation, &block)
      @values << Value.new(@schema, name, annotation, &block)
    end
  end
  
  class Package
    attr_reader :elements, :enums, :basic_types, :name, :annotation

    include Standards
    
    def initialize(schema, name, annotation, &block)
      #puts "Creating package #{name}"
      @schema, @name, @annotation = schema, name, annotation
      @elements = []
      @basic_types = []
      @enums = []
      @imported = schema.importing
      @standards = { }
      instance_eval &block
    end

    def type(name, annotation, parent = nil, &block)
      @elements << Element.new(@schema, name, annotation, parent, &block)
    end

    def basic_type(name, annotation, parent = 'string', attr = false, &block)
      @basic_types << BasicType.new(@schema, name, annotation, parent, attr, &block)
    end
    
    def attr(name, annotation, parent = 'string', attr = true, &block)
      BasicType.new(@schema, name, annotation, parent, attr, &block)
    end
  
    def enum(name, annotation, parent = 'NMTOKEN', attr = true, &block)
      @enums << ControlledVocabulary.new(@schema, name, annotation, parent, attr, &block)
    end
  end

  class Element < Type
    attr_reader :members, :parent

    def initialize(schema, name, annotation, parent = nil, &block)
      super(schema, name, annotation, parent)
      @name, @annotation, @parent = name, annotation, parent
      @abstract = false
      @mixed = false
      @members = []
      @children = []
      @schema.derived << @parent if @parent and @parent != :abstract
      instance_eval &block if block
    end
    
    def to_s
      "Element: #{@name}:#{@parent} #{@annotation}"
    end

    def abstract
      @abstract = true
    end
    
    def mixed
      @mixed = true
    end

    def abstract?
      @abstract
    end
    
    def mixed?
      @mixed
    end

    def subtype?
      !@parent.nil?
    end

    def resolve_parent
      if @parent
        par = @schema.type(@parent)
        raise "Cannot resolve parent type #{@parent}" unless par
      end
      par
    end

    def has_subtypes?
      @schema.derived.include? @name
    end

    def abstract_parent?
      pnt = resolve_parent
      while pnt
        return true if pnt.abstract?
        pnt = pnt.resolve_parent
      end
      false
    end

    def member(name, annotation, occurrence = nil, type = nil, &block)
      type, occurrence = occurrence, nil if Symbol === occurrence
      @members << Member.new(@schema, name, annotation, occurrence, type, &block)
    end
    
    def attribute(name, annotation, occurrence = nil, type = nil, &block)
      type, occurrence = occurrence, nil if Symbol === occurrence
      mem = Member.new(@schema, name, annotation, occurrence, type, &block)
      mem.attribute = true
      @members << mem
    end
    
    def element(name, annotation, occurrence = nil, type = nil, &block)
      type, occurrence = occurrence, nil if Symbol === occurrence
      mem = Member.new(@schema, name, annotation, occurrence, type, &block)
      mem.attribute = false
      @members << mem
    end

    def all_subtypes(base, occurrence = 0..INF)
      @members << Subtypes.new(@schema, base, occurrence)
    end

    def choice(occurrence = 1, &block)
      @members << Choice.new(@schema, occurrence, &block)
    end
    
    def at_least_one(occurrence = 1, &block)
      c = Choice.new(@schema, occurrence, &block)
      m, mc = c.members, c.members.dup
      m.clear
      (mc.size - 1).times do |i|
        s = ChoiceSet.new(@schema)
        (i...mc.size).each do |j|
          nm = mc[j].dup
          nm.occurrence = 0..1 if (j > i)
          s.members << nm
        end
        m << s
      end
      m << mc.last.dup
      @members << c
    end

    def <=>(other)
      @name <=> other.name
    end

    def restriction?(other)
      other_elems = other.members.select { |m| !m.attribute? and !m.is_a? Choice }.map { |m| m.name }
      elems = @members.select { |m| !m.attribute? and !m.is_a? Choice }.map { |m| m.name }
      if other_elems.empty? or elems.empty?
        false
      else
        other_elems == elems
      end
    end
    
    def children(deep = false)
      children = @children.dup
      if deep
        children.concat(@children.map { |c| c.children }.flatten)
      end
      children
    end
    
    def add_child(child)
      @children << child
    end
    
    def build_hierarchy
      if @parent
        unless @schema.type(@parent)
          puts "Cannot find parent '#{@parent.inspect}' for '#{self}'"
          exit 9
        end
        @schema.type(@parent).add_child(self)
      end
    end
    
    def resolve
      @members.each { |m| m.resolve }
    end
  end
  
  class Member
    include Comparable
    
    attr_reader :name, :type
    attr_accessor :occurrence, :annotation, :default
    
    INF = 0xFFFFFFFF

    include Standards
    
    def initialize(schema, name, annotation, occurrence = nil, type = nil, &block)
      @schema, @name, @annotation, @type = schema, name, annotation, type
      @occurrence = occurrence
      @type = @name unless @type
      @standards = { }
      @imported = schema.importing
      instance_eval &block if block
    end

    def <=>(other)
      @name <=> other.name
    end

    def resolve_type
      if @type == :any
        res = @type 
      else
        res = @schema.type(@type)
        unless res
          raise "Cannot resolve type #{@type} for #{@name}"
        end
      end
      res
    end

    def is_value?
      type = resolve_type
      @name == :Value and !type.is_a?(Element)
    rescue
      puts $!
      false
    end

    def attribute?
      if !defined?(@attribute)
        type = @schema.type(@type)
        @attribute = (@name != :Value and @name != :any and (type.nil? or type.attr))
      end
      @attribute
    end
    
    def attribute=(a)
      @attribute = a
    end

    def references_abstract?
      type = resolve_type
      type and type.is_a? Element and type.abstract? and (type.subtype? or type.has_subtypes?)
    end
    
    def resolve
    end
  end

  class Choice < Member
    attr_reader :members
    
    def initialize(schema, occurrence = 1, &block)
      @members = []
      super(schema, 'choice', 'choice', occurrence)
    end

    def member(name, annotation, occurrence = nil, type = nil, &block)
      type, occurrence = occurrence, nil if Symbol === occurrence
      @members << Member.new(@schema, name, annotation, occurrence, type, &block)
    end
    
    def set(occurrence = 1, &block)
      @members << ChoiceSet.new(@schema, occurrence, &block)
    end

    def attribute?
      false
    end

    def resolve_type
      nil
    end
  end
  
  class ChoiceSet < Member
    attr_reader :members
    
    def initialize(schema, occurrence = 1, &block)
      @members = []
      super(schema, 'sequence', 'sequence', occurrence)
    end
    
    def member(name, annotation, occurrence = nil, type = nil, &block)
      type, occurrence = occurrence, nil if Symbol === occurrence
      @members << Member.new(@schema, name, annotation, occurrence, type, &block)
    end
    
    def attribute?
      false
    end

    def resolve_type
      nil
    end
  end
  
  class Subtypes < Choice
    attr_reader :base
    
    def initialize(schema, base, occurrence = 0..INF)
      super(schema, occurrence)
      @base = base
    end
    
    # Add all the members for the type and all the subtypes
    def resolve
      type = @schema.type(base)      
      children = type.children(true)
      children.each do |child|
        member(child.name, child.annotation)
      end
      member(type.name, type.annotation)
    end
  end
end

