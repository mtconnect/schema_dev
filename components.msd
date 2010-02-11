
package :Component, 'Top Level Components Package' do
  attr :Station, 'The station id for this device'
  attr :Iso841Class, 'The ISO 841 classification for the device', :integer
  
  type :Devices, 'The top level components' do
    member :Device, 'A piece of equipment', 1..INF
  end

  type :Component, "An abstract component type. This is a placeholder for all components" do
    abstract
    member :id, 'The data item identifier', :ID
    member :Name, 'The components name'
    member :SampleRate, 'The rate at which the data is sampled from the component', 0..1
    member :Description, 'The descriptive information about this component', 0..1, :ComponentDescription
    member :DataItems, 'The component\'s Data Items', 0..1
    member :Components, 'The sub components', 0..1
  end

  type :ComponentDescription, 'The descriptive information for this component. This can be manufacturer specific' do
    member :Value, 'A text description of the component, will be replaced later by structed content', :DescriptionText
    member :Manufacturer, 'The manufacturer of this component', 0..1, :Name
    member :SerialNumber, 'The serial number of the component', 0..1
    member :Station, 'The location of this component', 0..1
  end
  
  type :CommonComponent, "An abstract component that has an optional uuid", :Component do 
    member :Uuid, 'The components universally unique id. This can be composed of the manufactures id or name and the serial number.', 0..1
  end

  type :Components, 'A list of generic components' do
    member :Component, 'Any component', 1..INF
  end
  
  type :Device, 'The top level component managed by the agent', :Component do
    standards :OMAC => 'resources'
    member :Iso841Class, 'The device\'s ISO-841 classification', 0..1
    member :Uuid, 'The components universally unique id. This can be composed of the manufactures id or name and the serial number.'
  end

  type :Controller, 'A controller', :CommonComponent do
    standards :OMAC => 'CNC'
  end

  type :Power, 'A power measuring component', :CommonComponent
  type :Sensor, 'A sensor, this is not abstract to allow for easy extensibility.', :CommonComponent
  type :Thermostat, 'A thermostate', :Sensor
  type :Vibration, 'A sensor for reading the vibration from a component', :Sensor
  type :Path, 'A path component', :CommonComponent
  
  type :Door, 'A door on the machine', :CommonComponent  
end
