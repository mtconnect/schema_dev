
package :interface, 'The interface component additions' do
  type :Interfaces, :CommonComponent
    
  type :Interface, 'A component representing an interface in a device.', :CommonComponent do
    abstract    
  end
  
  type :BarFeederInterface, :Interface
  type :MaterialHandlerInterface, :Interface
  type :DoorInterface, :Interface
  type :ChuckInterface, :Interface

end

