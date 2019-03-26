# coding: utf-8

package :Events, 'Event Package' do
  basic_type(:IntegerEventValue, 'Integer event value') {
    union(:integer, :UnavailableValue)
  }
  basic_type(:FloatEventValue, 'Integer event value') {
    union(:float, :UnavailableValue)
  }
  basic_type(:StringEventValue, 'Srring event value') {
    union(:string, :UnavailableValue)
  }
  basic_type(:StringListValue, 'A list of axis names') {
    list(:string)
  }
  basic_type(:StringListEventValue, 'A list of axis for an event') {
    union(:StringListValue, :UnavailableValue)
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

  type :StringListEvent, 'An unfaceted string event', :Event do
    member :Value, 'A string value', :StringListEventValue
  end

  type :IntegerEvent, 'An event with an integer value', :Event do
    member :Value, 'A string value', :IntegerEventValue
  end

  type :FloatEvent, 'An event with an integer value', :Event do
    member :Value, 'A string value', :FloatEventValue
  end

  facets = { "string" => :StringEvent,
             "integer" => :IntegerEvent,
             "float" => :FloatEvent,
             "arraystring" => :StringListEvent }

  Glossary.events.each do |event|
    unless event.kind_of?(:type) and event.name_property != "ALARM"
      next
    end
    
    value_type = facets[event.facet]
    unless value_type    
      puts "Warning: Cannot find facet for '#{event.name}' facet #{event.facet.inspect}, defaulting to string" 
      value_type = :StringEvent
    end
      
    if event.keys.include?(:enumeration)
      values = event.enumeration.split(',').map(&:strip)
      value_type = "#{event.elementname}Value".to_sym
      enum(value_type, "Controlled vocabulary for #{event.elementname}") do
        values.each do |v|
          entry = Glossary.entries[v]
          if entry
            value(entry.name_property, entry.description)
          else
            puts "Cannot find entry for #{v} -- #{event.name}"
          end
        end
        value(:UNAVAILABLE, 'Value is indeterminate')
      end
      
      type(event.elementname.to_sym, event.description, :Event) do
        member :Value, "the value for #{event.elementname}", value_type
      end
    else
      type(event.elementname.to_sym, event.description, value_type)      
    end
    
  end
      
  # Create discrete events for non-state events
  %w{PartCount ToolId ToolNumber ToolAssetId PalletId Message Block}.each do |s| 
    type = self.schema.type(s.to_sym) 
    self.type "#{type.name}Discrete".to_sym, "Discrete of #{type.annotation}", type.name
  end
end
