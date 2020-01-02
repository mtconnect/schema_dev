
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

  type :Controller, 'A controller', :CommonComponent do
    standards :OMAC => 'CNC'
  end

  type :Power, 'DEPRECATED: A power measuring component', :CommonComponent
  type :Sensor, 'A sensor, this is not abstract to allow for easy extensibility.', :CommonComponent
  type :Path, 'A path component', :CommonComponent
  type :Actuator, 'A component that causes motion', :CommonComponent
  type :Door, 'A door on the machine', :CommonComponent  
  type :Auxiliaries, 'An XML container used to organize information for \gls{lower level} elements representing functional sub-systems that provide supplementary or extended capabilities for a piece of equipment, but they are not required for the basic operation of the equipment.', :CommonComponent  

  type :Compositions, "A collection of sub elements" do
    member :Composition, 'An assembly of a component', 1..INF
  end

  basic_type(:CompositionTypeExt, 'An extension point for Composition') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  enum :CompositionEnumType, 'The vocab for the type of composition' do
    extensible :CompositionTypeExt
    value :ACTUATOR, 'A mechanism for moving or controlling a mechanical part of a piece of equipment'
    value :AMPLIFIER, 'An electronic component or circuit for amplifying power, current, or voltage'
    value :BALLSCREW, 'A mechanical structure for transforming rotary motion into linear motion'
    value :BATTERY, 'A storage device that stores and produces electrical engergy'
    value :BELT, 'An endless flexible band used to transmit motion for a piece of equipment or to convey materials and objects'
    value :CIRCUIT_BREAKER, 'A mechanism for interrupting an electric circuit'
    value :CHAIN, 'An interconnected series of objects that band together and used to transmit motion for a piece of equipment or to convey materials and objects.'
    value :CHUCK, 'A mechanism that holds a part, stock material, or any other item in place'
    value :CHUTE, 'An inclined channel for conveying material'
    value :CLAMP, 'A mechanism used to strengthen, support, or fasten objects in place'
    value :COMPRESSON, 'A pump or other mechanism for reducing volume and increasing pressure of gases in order to condense the gases  to drive pneumatically powered pieces of equipment'
    value :DOON, 'Amechanical mechanism or closure that can cover an access portal into a piece of equipment.'
    value :FAN, 'Any device for producing a current of air'
    value :FILTER, 'Any substance or structure through which liquids or gases are passed to remove suspended impurities or to recover solids.'
    value :GRIPPER, 'A mechanism that holds a part, stock material, or any other item in place'
    value :HOPPER, 'A chamber or bin in which materials are stored temporarily, being filled through the top and dispensed through the bottom.'
    value :MOTOR, 'A mechanism that converts electrical, pneumatic, or hydraulic energy into mechanical energy'
    value :PUMP, 'An apparatus raising, driving, exhausting, or compressing fluids or gases by means of a piston, plunger, or set of rotating vanes.'
    value :POSITION_FEEDBACK, 'A mechanism that measures motion or position'
    value :POWER_SUPPLY, 'A device that provides power to electric mechanisms'
    value :SWITCH, 'A mechanism for turning on or off an electric current or for making or breaking a circuit.'
    value :TANK, 'A receptacle or container for holding material'
    value :TRANSFORMER, 'A mechanism through which transforms electric energy from a source to a secondary circuit'
    value :VALVE, 'Any mechanism for halting or controlling the flow of a liquid, gas, or other material through a passage, pipe, inlet, or outlet,'
  end
  

  type :Composition, "An abstract element" do
    member :id, 'The data item identifier', :ID
    member :Uuid, 'The composition\'s universally unique id.', 0..1
    member :Name, 'The data item identifier', 0..1
    member :Type, 'The type of composition', :CompositionEnumType
    member :Description, 'The descriptive information about this sub element', 0..1, :ComponentDescription
  end  
end

load 'sensors'
