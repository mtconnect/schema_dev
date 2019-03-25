# coding: utf-8

package :Events, 'Event Package' do
  # Float values will come from Sample
  basic_type(:IntegerEventValue, 'Integer event value') {
    union(:'xs:integer', :UnavailableValue)
  }
  basic_type(:StringEventValue, 'Srring event value') {
    union(:'xs:string', :UnavailableValue)
  }
  basic_type(:AxisNameValue, 'An axis name') {
    pattern('[a-zA-Z][0-9]?')
  }
  basic_type(:AxisNameListValue, 'A list of axis names') {
    list(:AxisNameValue)
  }
  basic_type(:AxisNameListEventValue, 'A list of axis for an event') {
    union(:AxisNameListValue, :UnavailableValue)
  }

  type :Event, 'An abstract event' do
    abstract
    mixed
    member :Observation, 'The attributes for all observations'
    attribute :ResetTriggered, 'An optional indicator that the event or sample was reset', 0..1, :DataItemResetValue
  end

  type :StringEvent, 'An unfaceted string event', :Event do
    member :Value, 'A string value', :StringEventValue
  end
  
  Glossary.events.each do |event|
    value_type = :StringEventValue
    if event.keys.include?(:values)
      values = event.values.split(',').map(&:strip)
      value_type = "#{event.elementname}Value".to_sym
      enum(value_type, "Controlled vocabulary for #{event.elementname}") do
        values.each do |v|
          entry = Glossary.entries[v]
          if entry
            value(entry.name_property, entry.description)
          else
            puts "Cannot find entry for #{v}"
          end
        end
        value(:UNAVAILABLE, 'Value is indeterminate')
      end
      
      type(event.elementname.to_sym, event.description, :Event) do
        member :Value, "the value for #{event.elementname}", value_type
      end
    else
      type(event.elementname.to_sym, event.description, :StringEvent)      
    end
    
  end
      
  # Create discrete events for non-state events
  %w{PartCount ToolId ToolNumber ToolAssetId PalletId Message Block}.map do |s| 
    self.schema.type(s.to_sym) 
  end.each do |type|
    self.type "#{type.name}Discrete".to_sym, "Discrete of #{type.annotation}", type.name
  end
end
