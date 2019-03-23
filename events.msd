# coding: utf-8

package :Events, 'Event Package' do
  integer_value = '[+-]?\d+|UNAVAILABLE'
  float = '[+-]?\d+(\.\d+)?([Ee][+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  line_pattern = "[A-Za-z0-9]*|UNAVAILABLE"
  
  basic_type(:PartCountValue, 'The number of parts') { pattern integer_value }
  basic_type :BlockValue, 'Code block value'
  basic_type :CodeValue, 'Value of the program code'
  basic_type :ProgramValue, 'The program name'
  basic_type :ToolEventValue, 'A tool event'
  basic_type(:LineValue, 'The line number') { pattern line_pattern }
  basic_type :ToolIdValue, 'The tool identifier'
  basic_type :AssetIdValue, 'The tool identifier'
  basic_type :PartIdValue, 'The part identifier'
  basic_type :MessageValue, 'A message'
  basic_type(:AxesListValue, 'A space delimited list of values') { pattern 'UNAVAILABLE|[a-zA-Z][0-9]*( [a-zA-Z][0-9]*)*' }
  basic_type(:OverrideValue, 'The value for a percent override') { pattern float_value }

  basic_type :TextValue, 'A un-faceted text value'

  type :Event, 'An abstract event', :Result do
    abstract
    attribute :ResetTriggered, 'An optional indicator that the event or sample was reset', 0..1, :DataItemResetValue
  end  

  Glossary.events.each do |event|
    value_type = :TextValue
    if event.keys['values']
      values = event.keys['values'].split(',').map(&:strip)
      value_type = "#{event.keys['elementname']}Value".to_sym
      enum(value_type, "Controlled vocabulary for #{event.keys['elementname']}") do
        values.each do |v|
          entry = Glossary.entries[v]
          if entry
            value(entry.keys['name'], entry.keys['description'])
          else
            puts "Cannot find entry for #{v}"
          end
        end
        value(:UNAVAILABLE, 'Value is indeterminate')
      end
    end
    
    type(event.keys['elementname'].to_sym, event.keys['description'], :Event) do
      member :Value, "the value for #{event.keys['elementname']}", value_type
    end
  end
      
  # Create discrete events for non-state events
  %w{PartCount ToolId ToolNumber ToolAssetId PalletId Message Block}.map do |s| 
    self.schema.type(s.to_sym) 
  end.each do |type|
    self.type "#{type.name}Discrete".to_sym, "Discrete of #{type.annotation}", type.name
  end
  
  attr :Order, 'The order in which something will be done', :integer
  basic_type :TransformationValue, 'The transformation name'
  
end
