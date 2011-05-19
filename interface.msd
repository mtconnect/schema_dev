
package :interface, 'The interface component additions' do
  type :Interfaces, 'A component representing all the interfaces in a device.', :CommonComponent
  attr :DataItemIdRef, 'A reference to an data item', :IDREF
  
  type :DataItemRef, 'A reference to a data item and component' do
    member :idref, 'A reference to the data item', :DataItemIdRef
  end
  
  type :References, 'A list of references' do
    member :DataItemRef, 'A reference to a data item or component', 1..INF
  end
  
  type :Interface, 'A component representing all the interfaces in a device.', :CommonComponent do
    abstract
    
    member :References, 'A list of referenced components and data items', 0..1
  end
  
  type :BarFeeder, 'A bar feeder component', :Interface
end

