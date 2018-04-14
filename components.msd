
package :Component, 'Top Level Components Package' do
  attr :Station, 'The station id for this device'
  attr :Iso841Class, 'The ISO 841 classification for the device', :integer
  attr :Model, 'The model name'
  
  type :Devices, 'The top level components' do
    member :Device, 'A piece of equipment', 1..INF
  end
  
  # Data Item References for Streams
  attr :IdRef, 'A reference to an identifier', :IDREF
  
  type :Reference, 'An abstract reference type' do
    abstract
    member :IdRef, 'A reference to an id in the MTConnectDevices model'
    member :Name, 'An optional name of the referenced item, used for documentation', 0..1
  end
  
  type :References, 'A list of references' do
    member :Reference, 'A reference to another part of the model', 1..INF
  end
  
  type :DataItemRef, 'A data item reference', :Reference
  type :ComponentRef, 'A data item reference', :Reference
  
  type :Component, "An abstract component type. This is a placeholder for all components" do
    abstract
    member :id, 'The data item identifier', :ID
    member :NativeName, 'The device manufacturer component name', 0..1, :Name
    member :SampleInterval, 'The rate at which the data is sampled from the component', 0..1
    member :SampleRate, 'DEPRECATED: The rate at which the data is sampled from the component', 0..1, :DataItemSampleRate
    member :Description, 'The descriptive information about this component', 0..1, :ComponentDescription
    member :Configuration, 'The configuration information about this component', 0..1, :ComponentConfiguration
    member :DataItems, 'The component\'s Data Items', 0..1
    member :Components, 'The sub components', 0..1
    member :Compositions, 'A list of composition elements', 0..1
    member :References, 'A list of references', 0..1
  end

  type :ComponentDescription, 'The descriptive information. This can be manufacturer specific' do
    mixed
    
    member :Manufacturer, 'The manufacturer', 0..1, :Name
    member :Model, 'The model', 0..1
    member :SerialNumber, 'The serial number', 0..1
    member :Station, 'The station location', 0..1
    member :any, 'The content of the description can text or XML elements', 0..INF
  end
  
  type :AbstractConfiguration, 'Abstract configuration' do
    abstract
  end
  
  type :ComponentConfiguration, 'The configuration data associated with this component. For example, sensors may use 1451.5 or TEDS' do
    mixed
    
    member :Configuration,  'Configuration types', 0..1, :AbstractConfiguration
  end
    
  type :CommonComponent, "An abstract component that has an optional uuid", :Component do 
    member :Uuid, 'The component\'s universally unique id.', 0..1
    member :Name, 'The component\'s name', 0..1
  end

  type :Components, 'A list of generic components' do
    member :Component, 'Any component', 1..INF
  end
  
  type :Device, 'The top level component managed by the agent', :Component do
    standards :OMAC => 'resources'
    member :Iso841Class, 'DEPRECATED: The device\'s ISO-841 classification', 0..1
    member :Uuid, 'The components universally unique id. This can be composed of the manufactures id or name and the serial number.'
    member :Name, 'The Device name.'
    member :Version, 'The MTConnect Version this Device implements', 0..1
  end

  type :Controller, 'A controller system for a machine tool', :CommonComponent

  type :Power, 'DEPRECATED: A power measuring component', :CommonComponent
  type :Path, 'A path component', :CommonComponent
  type :Actuator, 'A component that causes motion', :CommonComponent
  type :Door, 'A door on the machine', :CommonComponent  

end

load 'sensors'
