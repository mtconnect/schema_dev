
package :Component, 'Top Level Components Package' do
  attr :Station, 'The station id for this device'
  attr :Iso841Class, 'The ISO 841 classification for the device', :integer
  attr :Model, 'The model name'
  
  type :Devices, 'The top level components' do
    member :Device, 'A piece of equipment', 1..INF
  end
  
  # Data Item References for Streams
  attr :IdRef, 'A reference to an identifier', :IDREF
  attr :DeviceUuid, 'The uuid this tool is associated with', :Uuid

  enum :Relationship, 'relationships' do
    value :PARENT, 'The reference is to a parent'
    value :CHILD, 'The reference is to a child'
    value :PEER, 'The reference is to a peer'
  end

  enum :Significance, 'The criticalities' do
    value :REQUIRED, 'The realtion is required'
    value :OPTIONAL, 'The relation is optional'
    value :CRITICAL, 'The relation is optional'
  end
  
  type :Reference, 'An abstract reference type' do
    abstract
    member :IdRef, 'A reference to an id in the MTConnectDevices model'
    member :Name, 'An optional name of the referenced item, used for documentation', 0..1
    member :Relation, 'The relationship to the other item', 0..1, :Relationship
    member :Significance, 'The criticality of the relationship', 0..1, :Significance
  end
  
  type :References, 'A list of references' do
    member :Reference, 'A reference to another part of the model', 1..INF
  end
  
  
  type :DataItemRef, 'A data item reference', :Reference
  type :ComponentRef, 'A data item reference', :Reference
  type :DeviceRef, 'A data item reference', :Reference do
    member :DeviceUuid, 'The identity of the device'
    attribute :'xlink:href', 'Reference to the url of the related device', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href fixed at located', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end
  
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
    member :SerialNumber, 'The serial number', 0..1, :SerialNumberAttr
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

  type :Device, :Component do
    standards :OMAC => 'resources'
    member :Iso841Class, 'DEPRECATED: The device\'s ISO-841 classification', 0..1
    member :Uuid, 'The components universally unique id. This can be composed of the manufactures id or name and the serial number.'
    member :Name, 'The Device name.'
    member :Version, 'The MTConnect Version this Device implements', 0..1
  end

  Glossary.components.each do |component|
    parent = :CommonComponent
    if component.kind.first != :component
      kind = component.kind.first.to_s
      pe = Glossary[kind]
      unless pe
        kind = Glossary.singular(kind)
        pe = Glossary[kind]
      end
      if pe
        # puts "Parent of #{component.name} #{kind} = #{pe.name_property}"
        parent = pe.name_property.to_sym
      end
    end
    t = type component.name_property.to_sym, component.description, parent
    if component.has_key?(:kindplural) and component.kindplural == "component"
      t.abstract
      desc = component[:descriptionplural] || component.description
      type component.plural.to_sym, desc, parent
    end
  end

  # Composition Information
  type :Compositions, "A collection of sub elements" do
    member :Composition, 'An assembly of a component', 1..INF
  end

  basic_type(:CompositionTypeExt, 'An extension point for Composition') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  enum :CompositionEnumType, 'The vocab for the type of composition' do
    extensible :CompositionTypeExt

    Glossary.compositions.each do |e|
      value(e.name_property, e.description) if !e.kind_of?(:subtype)
    end
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
load 'specifications'
