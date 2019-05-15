package :Relationships, 'Relationship models' do
  # Relationships
  type :Relationships, 'A set of relationships', :AbstractConfiguration do
    member :Relationship, 'A relationship', 1..INF
  end

  enum :AssociationEnum, 'The list of possible association types' do
    value :PARENT, 'The related entity is a parent'
    value :CHILD, 'The related entity is a child'
    value :PEER, 'The related entity is a peer'
  end

  enum :RelationshipTypeEnum, 'Types of relationships' do
    value :MASTER, 'a master'
    value :SLAVE, 'a slave'
  end

  enum :DeviceRelationshipTypeEnum, 'device relationships', :RelationshipTypeEnum do
    value :SYSTEM, 'a system'
    value :AUXILIARY, 'an auxiliary'
  end

  enum :CriticalityEnum, 'The criticality' do
    value :CRITICAL, 'critical'
    value :NON_CRITICAL, 'Not critical'
  end

  type :Relationship, 'A relationship between this component and something else' do
    abstract
    member :Id, 'The coordinate system identifier', :ID
    member :Name, 'The optional name of the relationship', 0..1
    member :Association, 'The assciation type', :AssociationEnum
    member :Criticality, 'Criticality', 0..1, :CriticalityEnum
  end
  
  type :DeviceRelationship, 'A relationship to a device', :Relationship do
    member :DeviceUuidRef, 'A reference to the device uuid', :Uuid
    member :Type, 'The type of relatiship', 0..1, :DeviceRelationshipTypeEnum
    attribute :href, 'Reference to the url of the related device', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href fixed at located', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end

  type :ComponentRelationship, 'A relationship to a device', :Relationship do
    member :Type, 'The type of relatiship', 0..1, :RelationshipTypeEnum
    member :ComponentIdRef, 'A reference to the device uuid', :IdRef
  end
end
