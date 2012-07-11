
package :InterfaceStream, 'A stream of interfaces' do
  enum :InterfaceValues, 'Interface state' do
    value :READY, 'The interface is in an idle state'
    value :ACTIVE, 'The interface is executing an activity'
    value :COMPLETE, 'The executor is finished with the activity'
    value :FAIL, 'The activity failed'
  end
  
  type :InterfaceEvent, 'Abstract interface event type. Values are limited to the event states', :Event do
    abstract
    member :Value, 'Program code', :InterfaceValues
  end
  
  type :MaterialFeed, 'Material feed interface', :InterfaceEvent
  type :MaterialChange, 'Material change interface', :InterfaceEvent
  type :MaterialRetract, 'Material retract interface', :InterfaceEvent
  type :PartChange, 'Part change interface', :InterfaceEvent
  
  enum :InterfaceStates, 'The states of the interface' do
    value :ENABLE, 'The interface is enabled'
    value :DISABLE, 'The interface is disabled'
  end
  
  type :InterfaceState, 'The enable/disabled state of the interface', :Event do
    member :Value, 'The states of the interface', :InterfaceStates
  end
end

