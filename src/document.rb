

require 'parser'
require 'rubygems'
require 'redcloth'

$dir = "documentation"

class Schema

  def generate_all(root)
    generate('big.dot', nil, true)
    system "dot -Tpng -o#{root}_big.png big.dot"
    
    @packages.each do |package, types|
      fn = package.name.to_s.tr(' ', '_')
      generate("#{fn}.dot", package)
      system "dot -Tpng -o#{root}_#{fn}.png #{fn}.dot"
      File.unlink("#{fn}.dot")
    end
  end
  
  def generate(filename, package = nil, big = false)
    puts "Generating #{filename}"
    File.open(filename, "w") do |o|
      o.puts "digraph vocabulary {"
      unless big
        o.puts "size = \"7,10\";"
        #o.puts "page=\"8.5,10\";"
      end
      o.puts "fontname=Helvetica;"
      o.puts "node [fontname=Helvetica,shape=box,fontsize=10,fillcolor=lightblue,style=filled];"
      o.puts "edge [fontname=Helvetica,fontsize=10,labelfontsize=10];"
      o.puts "bgcolor=gray95;"
      o.puts "concentrate=true;"
      if package
        package.generate_type_graph(o)
      else
        @packages.each do |pack|
          pack.generate_type_graph(o)
        end
      end
      if package
        package.generate_subgraph(o, 1)
      else
        @packages.each_with_index do |pack, i|
          pack.generate_subgraph(o, i + 1)
        end
      end
      
      o.puts "}"
    end
  end

  def generate_html
    out = "h1. Overview\n\n"
    out << "!{width:700px}#{$base}_big.png!:#{$base}_big.png\n\n"
    packages.each do |package|
      package.generate_html(out)
    end
    out
  end
  
  class Package
    def generate_subgraph(o, ind)
      o.puts "subgraph \"cluster_#{ind}\" {"
      o.puts "label=\"#{@name}\";"
      o.puts "style=filled; fillcolor=gray80;"
      @elements.each do |type|
        o.puts type.node_text
      end
      o.puts "}"
    end

    def generate_type_graph(o)
      @elements.each do |type|
        type.generate_type_graph(o)
      end
    end

    def generate_html(out)
      out << "h1. #{@name} Package\n\n"
      out << "h3. #{@annotation}\n\n"
      out << %{<div class="package">\n\n}
      out << "!#{$base}_#{name}.png!\n\n"
      @elements.each do |type|
        type.generate_html(out)
      end
      
      out << "h2. Basic Types\n\n"
      @basic_types.each do |type|
        type.generate_html(out)
      end
      
      out << "h2. Controlled Vocabularies\n\n"
      enums.each do |type|
        type.generate_html(out)
      end

      out << "</div>\n\n"
    end
  end

  class Member
    def occurrence_text
      if Range === @occurrence
        last = @occurrence.last == INF ? 'n' : @occurrence.last
        "#{@occurrence.first}..#{last}"
      else
        @occurrence.to_s
      end
    end

    def generate_type_graph(o, parent)
      type = resolve_type
      if type and !attribute? and !is_value?
        o.puts "\"#{parent.name}\" -> \"#{@type}\" [label=\"#{@name} #{occurrence_text}\"];"
      end
    end

    def generate_html(out)
      out << "|*#{@name}*|#{@type}|#{@annotation}|"
      self.all_standards(true).each do |s, v|
        out << "#{v}&nbsp;|"
      end
      out << "\n"
    end
  end

  class Choice
    def generate_type_graph(o, parent)
      @members.each do |mem|
        mem.generate_type_graph(o, parent)
      end
    end

    def generate_html(out)
      @members.each do |choice|
        choice.generate_html(out)
      end
    end
  end
  
  class Element
    def generate_type_graph(o)
      @members.each do |mem|
        mem.generate_type_graph(o, self)
      end
      if subtype?
        o.puts "\"#{@parent}\" -> \"#{@name}\" [arrowhead=none,arrowtail=odot];"
      end
    end
    
	def node_text
      s = "\"#{@name}\""
      mems = []
      @members.each do |mem|
        type = mem.resolve_type
        if !(mem.is_a? Choice) and (type.nil? or mem.attribute? or mem.is_value?)
          occurrence = " [#{mem.occurrence_text}] " unless mem.occurrence.nil? or mem.occurrence == 1
          mems << "#{mem.name} #{occurrence} : #{mem.type}"
        end
      end
      leader = trailer = nil
      unless mems.empty?
        leader = '{'
        trailer = '}'
      end
      if @type
        type = @type.gsub(/([<>])/) { "\\#{$1}" }
        s << " [shape=record,color=red,fillcolor=ivory,label=\"{#{type}|{#{@name}}"
        trailer = '}'
      else
        s << " [shape=record,color=red,fillcolor=ivory,label=\"#{leader}#{@name}"
      end
      unless mems.empty?
        mems = mems.map! do |r|
          r.ljust(@name.to_s.length + 5).gsub(' ', '\\\\ ')
        end
        s << "|{#{mems.join('\l')}\\l}"
      end
      s << "#{trailer}\"];"
      s
	end

    def generate_html(out)
      out << "<div class=\"type\">\n\n"
      out << "h2. #{@name} Type "
      out << "(#{@parent})" if @parent
      out << "\n\nh3. #{@annotation}\n\n"
      unless self.all_standards.empty?
        out << '|'
        self.all_standards.each { |s, v| out << "*#{s}*|" }
        out << "\n|"
        self.all_standards.each do |s, v|
          out << "#{v}&nbsp;|"
        end
        out << "\n\n"
      end
      
      attrs, elems = @members.partition { |ele| ele.attribute? }
      
      unless attrs.empty?
        out << "h3. Attributes\n\n"
        out << "|*Attribute*|*Type*|*Description*|"
        self.standards_header.each { |s| out << "*#{s}*|" }
        out << "\n"
        attrs.each do |mem|
          mem.generate_html(out)
        end
      end
      
      unless elems.empty?
        out << "\nh3. Members\n\n"
        out << "|*Member*|*Type*|*Description*|"
        self.standards_header.each { |s| out << "*#{s}*|" }
        out << "\n"
        elems.each do |mem|
          mem.generate_html(out)
        end
      end
      out << "\n</div>\n\n"
    end
  end

  class BasicType
    def generate_html(out)
      out << %{<div class="type">\n\n}
      out << "h3. #{@name} Type"
      out << "(#{@parent})" if @parent
      out << "\n\nh4. #{@annotation}\n\n"
      unless self.all_standards.empty?
        out << '|'
        self.all_standards.each { |s, v| out << "*#{s}*|" }
        out << "\n|"
        self.all_standards.each do |s, v|
          out << "#{v}&nbsp;|"
        end
      end
      out << "\n\n</div>\n\n"
    end
  end

  class ControlledVocabulary
    def generate_html(out)
      out << %{<div class="type">\n\n}
      out << "h3. #{@name} Type "
      out << "(#{@parent})" if @parent
      out << "\n\nh4. #{@annotation}\n\n"
      unless self.all_standards.empty?
        out << '|'
        self.all_standards.each { |s, v| out << "*#{s}*|" }
        out << "\n|"
        self.all_standards.each do |s, v|
          out << "#{v}&nbsp;|"
        end
        out << "\n\n"
      end
      
      out << "\nh4. Values\n\n"
      out << "|*Value*|*Description*|"
      self.standards_header.each { |s, v| out << "*#{s}*|" }
      out << "\n"
      @values.each do |value|
        out << "|#{value.name}|#{value.annotation}|"
        value.all_standards(true).each do |s, v|
          out << "#{v}&nbsp;|"
        end
        out << "\n"
      end
      out << "\n\n</div>\n\n"
    end
  end
end

$base = File.basename(ARGV[0], '.msd')
schema = Schema.new File.read(ARGV[0])
schema.generate_all("documentation/#{$base}")
out = schema.generate_html

doc = RedCloth.new out
File.open("documentation/#{$base}.html", 'w') do |f|
  f.write <<-EOT
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
<title>MTConnect Schema Documentation</title>
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size: small;
    margin: 1em; padding: 0;
}

table {
  border: 2px solid black;
  border-collapse: collapse;
}

tr, td {
  border: 1px solid black;
}

td {
  padding: 0.25em;
}

div.type {
  background: #E0E0E0;
  padding: 1em;
  margin: 1em 0 1em 1em;
}

div.package {
  margin-left: 1em;
}
</style>
</head>
<body>
EOT
  f.write doc.to_html
  f.write <<-EOT
</body>
</html>
EOT
end
