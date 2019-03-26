require 'rubygems'
require 'treetop'
require 'set'

Treetop.load 'src/latex'

class LatexParser
  attr_reader :entries
  
  def parse_glossary(file)
    res = parse(File.read(file))
    unless res
      puts parser.failure_reason
      puts @parser.terminal_failures.join("\n")
      exit
    end

    @indexes = Hash.new { |h, k| h[k] = [] }        
    @entries = Hash.new
    @plural = Hash.new
    @singular = Hash.new
    
    res.elements.each do |e|
      next unless Latex::GlossaryEntry === e

      if e.kind
        e.kind.each do |k|
          @indexes[k] << e
        end
      end

      name = e.name.join(' ')
      @entries[name] = e

      if e.has_key?(:plural)
        plural = e.plural.downcase
        
        @entries[plural] = e
        @singular[plural] = name
        @plural[name] = plural
      end
    end

    puts "Entries: #{@entries.length}"
    @indexes.each do |kind, list|
      puts "  #{kind}: #{list.count}"
    end
  end

  def plural(word)
    return @plural[word] if @plural.include?(word)
    case word
    when /(o|s|ss|ch|x)$/
      "#{word}es"

    when /y$/
      "#{words.slice(0...-1)}ies"

    else
      "#{word}s"
    end
  end

  def singular(word)
    return @singular[word] if @singular.include?(word)
    case word
    when /(o|s|ss|ch|x)es$/
      word.slice(0...-2)

    when /ies$/
      "#{word.slice(0...-3)}y"
      
    when /s$/
      word.slice(0...-1)

    else
      word
    end
  end
  
  def method_missing(m, *args, &block)
    [m, m.to_s.downcase.to_sym].each do |s|
      return @indexes[s] if @indexes.include?(s)
      ms = singular(s.to_s).to_sym
      return @indexes[ms] if @indexes.include?(ms)
      ms = plural(s.to_s).to_sym
      return @indexes[ms] if @indexes.include?(ms)
    end
    
    super
  end

  def [](key)
    @entries[key]
  end
end

module Latex
  class GlossaryEntry
    attr_accessor :parent, :elements
    
    def initialize(text, range, elements)
      @elements = elements
    end

    def inspect
      "\#<#{self.class.name}: #{@name} #{keys.inspect}>"
    end

    def name
      if !defined? @name
        @name = name_tokens.elements.map(&:value).compact
      end
      @name
    end

    def keys
      if !defined? @keys
        @keys = Hash.new
        properties.elements.map(&:value).compact.each do |k, v|
          @keys[k.to_sym] = v
        end
      end
      @keys
    end

    def has_key?(key)
      keys.include?(key)
    end

    def name_property
      keys[:name].gsub('$', '')
    end

    def kind
      if !defined? @kind
        kind = keys[:kind]
        @kind = kind.split(',').map(&:to_sym) if kind
      end
      @kind
    end

    def kind_of?(k)
      (kind and @kind.include?(k))
    end
    
    def method_missing(method, *args, &block)
      if !keys.include?(method)
        puts "Cannot find entry: #{@name} #{keys.inspect}"      
        super
      else
        keys[method]
      end
    end
    
    def dump
      puts "Name: #{name.inspect}"
      puts "Keys: #{keys.inspect}"
    end
    
    def to_s
      "#{name.inspect} -> #{keys.inspect}"
    end
  end
  
  class Property < Treetop::Runtime::SyntaxNode
    def value
      [key.text_value, context.value]
    end
  end
  
  class Command < Treetop::Runtime::SyntaxNode
    def command
      if !defined? @command
        @command = name.value
      end
      @command
    end

    def value
      if content.respond_to? :value
        content.value
      else
        command
      end
    end
  end
end
