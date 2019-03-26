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
    
    res.elements.each do |e|
      next unless Latex::GlossaryEntry === e

      if e.kind
        e.kind.each do |k|
          @indexes[k] << e
        end
      end

      @entries[e.name.join(' ')] = e
    end

    puts "Entries: #{@entries.length}"
    @indexes.each do |kind, list|
      puts "  #{kind}: #{list.count}"
    end
  end

  def method_missing(m, *args, &block)
    2.times do
      return @indexes[m] if @indexes.include?(m)

      ms = m.to_s
      if ms =~ /s$/
        # de-pluralize
        sg = ms.sub(/s$/, '').to_sym
        return @indexes[sg] if @indexes.include?(sg)
      else
        # pluralize
        pl = "#{ms}s".to_sym
        return @indexes[pl] if @indexes.include?(pl)
      end
      
      ms = ms.downcase
      m = ms.to_sym
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
