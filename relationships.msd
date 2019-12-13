package :Relationships, 'Relationship models' do
  # Relationships
  type :Relationships, 'A set of relationships', :AbstractConfiguration do
    member :Relationship, 'A relationship', 1..INF
  end

  enum :RelationshipTypeEnum, 'The list of possible association types' do
    value :PARENT, 'The related entity is a parent'
    value :CHILD, 'The related entity is a child'
    value :PEER, 'The related entity is a peer'
  end

  enum :DeviceRoleEnum, 'device relationships' do
    value :SYSTEM, 'a system'
    value :AUXILIARY, 'an auxiliary'
  end

  enum :CriticalityEnum, 'The criticality' do
    value :CRITICAL, 'critical'
    value :NON_CRITICAL, 'Not critical'
  end

  type :Relationship, 'A relationship between this component and something else' do
    abstract
    member :Id, 'The relationship identifier', :ID
    member :Name, 'The optional name of the relationship', 0..1
    member :Type, 'The assciation type', :RelationshipTypeEnum
    member :Criticality, 'Criticality', 0..1, :CriticalityEnum
  end

  type :ComponentRelationship, 'A relationship to a component', :Relationship do
    member :IdRef, 'A reference to the device uuid'
  end

  type :DeviceRelationship, 'A relationship to a device', :Relationship do
    member :DeviceUuidRef, 'A reference to the device uuid', :Uuid
    member :Role, 'The type of relatiship', 0..1, :DeviceRoleEnum
    attribute :href, 'Reference to the url of the related device', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href fixed value locator', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end
end
