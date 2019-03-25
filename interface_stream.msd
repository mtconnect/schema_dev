
package :InterfaceStream, 'A stream of interfaces' do
  # Interface events
  enum :InterfaceEventValues, 'The possible values for an interface event' do
    value :UNAVAILABLE, 'The value is unavailable'
    value :NOT_READY, 'The interface is not ready'
    value :READY, 'The interface is ready'
    value :ACTIVE, 'The interface is actively executing'
    value :COMPLETE, 'The interface has completed the action'
    value :FAIL, 'The interface action has failed'
  end

  type :InterfaceEvent, 'An abstract interface event', :Event do
    abstract
    member :Value, 'Interface values', :InterfaceEventValues
  end

#  type :MaterialFeed, 'Requests material is fed into a device from a feeder', :InterfaceEvent
#  type :MaterialChange, 'Requests the device change the type of material being loaded or fed', :InterfaceEvent
#  type :MaterialRetract, 'Requests the material be removed from the device by retraction', :InterfaceEvent
#  type :PartChange, 'Requests that the type of part being made be changed. Coupled with PART_ID to indicate the part', :InterfaceEvent
#  type :MaterialLoad, 'A request for material to be loaded into the device.', :InterfaceEvent
#  type :MaterialUnload, 'A request for material to be unloaded from a device.', :InterfaceEvent
#  type :OpenDoor, 'A request for the device to open a door.', :InterfaceEvent
#  type :CloseDoor, 'A request for the device to close a door.', :InterfaceEvent
#  type :OpenChuck, 'A request for the device to open a chuck.', :InterfaceEvent
#  type :CloseChuck, 'A request for the device to close a chuck.', :InterfaceEvent

  enum :InterfaceStates, 'The state of the interface' do
    value :UNAVAILABLE, 'The value is unavailable'
    value :ENABLED, 'The interface is enabled'
    value :DISABLED, 'The interface is disabled'
  end

#  type :InterfaceState, 'The enable/disabled state of the interface', :Event do
#    member :Value, 'The states of the interface', :InterfaceStates
#  end
end

