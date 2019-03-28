package :References, 'References between entities' do
  # Data Item References for Streams
  attr :IdRef, 'A reference to an identifier', :IDREF
  attr :DeviceUuid, 'The uuid this tool is associated with', :Uuid

  type :References, 'A list of references' do
    member :Reference, 'A reference to another part of the model', 1..INF
  end
  
  enum :Relationship, 'relationships' do
    value :PARENT, 'The reference is to a parent'
    value :CHILD, 'The reference is to a child'
    value :PEER, 'The reference is to a peer'
  end

  enum :Significance, 'The criticalities' do
    value :REQUIRED, 'The realtion is required'
    value :OPTIONAL, 'The relation is optional'
    value :CRITICAL, 'The relation is critical'
  end
  
  type :Reference, 'An abstract reference type' do
    abstract
    member :Name, 'An optional name of the referenced item, used for documentation', 0..1
    member(:Significance, 'The criticality of the relationship', 0..1, :Significance) { self.default = :OPTIONAL }
  end

  type :LocalReference, 'A reference to a data item or component', :Reference do
    member :IdRef, 'A reference to an id in the MTConnectDevices model'
  end
  
  type :DataItemRef, 'A data item reference', :LocalReference
  
  type :ComponentRef, 'A data item reference', :LocalReference do
    member :Relation, 'The relationship to the other item', 0..1, :Relationship
  end
  
  type :DeviceRef, 'A data item reference', :Reference do
    member :DeviceUuid, 'The identity of the device'
    member :Relation, 'The relationship to the other item', 0..1, :Relationship
    attribute :href, 'Reference to the url of the related device', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href fixed at located', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end
end
