require 'rubygems'
require 'treetop'
require 'set'

Treetop.load 'src/latex'

class LatexParser
  attr_reader :events, :samples, :conditions, :subtypes, :entries
  
  def parse_glossary(file)
    res = parse(File.read(file))
    unless res
      puts parser.failure_reason
      puts @parser.terminal_failures.join("\n")
      exit
    end

    @entries = Hash.new
    @events = []
    @samples = []
    @conditions = []
    @subtypes = []

    uniq = Set.new
    res.elements.each do |e|
      next unless Latex::GlossaryEntry === e

      last = e.name.last
      len = e.name.length
      if len == 2
        case last
        when 'event'
          @events << e

        when 'sample'
          @samples << e

        when 'condition'
          @conditions << e
        end
      elsif len == 3 and (last == 'event' or last == 'sample') and
           !uniq.include?(e.name.first)
        @subtypes << e
        uniq << e.name.first
      end

      @entries[e.name.join(' ')] = e
    end

    puts "Entries: #{@entries.length}"
    puts "  Events: #{@events.length}"
    puts "  Samples: #{@samples.length}"
    puts "  Conditions: #{@conditions.length}"
    puts "  Subtypes: #{@subtypes.length}"
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

    def name
      if !defined? @name
        @name = name_tokens.elements.map(&:value).compact
      end
      @name
    end

    def keys
      if !defined? @keys
        @keys = Hash[properties.elements.map(&:value).compact]
      end
      @keys
    end

    def element_name
      keys['name']
    end

    def description
      keys['description']
    end

    def method_missing(method, *args, &block)
      keys[method.to_s]
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
