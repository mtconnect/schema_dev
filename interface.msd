
package :interface, 'The interface component additions' do
  type :Interfaces, 'A component representing all the interfaces in a device.', :CommonComponent
    
  type :Interface, 'A component representing an interface in a device.', :CommonComponent do
    abstract    
  end
  
  type :BarFeederInterface, 'An interface to a bar feeder device', :Interface
  type :MaterialHandlerInterface, 'An interface to a device that can load and unload material', :Interface
  type :DoorInterface, 'An interface to control a door', :Interface
  type :ChuckInterface, 'An interface to control a chuck', :Interface

end

