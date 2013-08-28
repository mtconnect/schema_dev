
package :interface, 'The interface component additions' do
  type :Interfaces, 'A component representing all the interfaces in a device.', :CommonComponent
  
  # Data Item References for Streams
  attr :Idref, 'A reference to an identifier', :IDREF

  type :Reference, 'An abstract reference to a data item or component' do
    abstract
    member :Name, 'An optional name of the referenced item, used for documentation', 0..1
  end

  type :DataItemReference, 'A reference to a data item', :Reference do
    member :DataItemId, 'A reference to a data item', :Idref
  end
  
  type :ComponentReference, 'A reference to a Component', :Reference do
    member :ComponentId, 'A reference to a component', :Idref
  end

  type :References, 'A list of references' do
    member :Reference, 'A reference to a data item or component', 1..INF
  end
  
  type :Interface, 'A component representing all the interfaces in a device.', :CommonComponent do
    abstract    
    member :References, 'A list of referenced components and data items', 0..1
  end
  
  type :BarFeeder, 'An interface to a bar feeder device', :Interface
  type :MaterialHandler, 'An interface to a device that can load and unload material', :Interface
  type :DoorInterface, 'An interface to control a door', :Interface
  type :ChuckInterface, 'An interface to control a chuck', :Interface

end

