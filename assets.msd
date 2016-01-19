
package :Assets, 'Mobile Assets' do
  attr :Source, 'A URI reference', :anyURI
  attr :Removed, 'A flag indicating the item has been removed', :boolean
  
  type :AssetDescription, 'The description of an asset, can be free form text or elements' do
    mixed
    member :any, 'Any elements', 0..INF
  end  
  
  type :Assets, 'The collection of mobile assets' do
    choice(0..INF) do
      member :Asset, 'A tool assembly'
    end
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :AssetId, 'The unique identifier of the asset'
    member :Timestamp, 'The time asset information was recorded'
    member :DeviceUuid, 'The uuid this tool is associated with', 0..1, :Uuid
    member :Removed, 'The asset has been marked as removed', 0..1
  end
  
  type :AssetInstance, 'An abstract asset instance', :Asset do
    abstract
    member :AssetArchetypeRef, 'A reference to the asset architype for instances', 0..1
    member :Description, 'The description of the file (freeform)', 0..1, :AssetDescription
    member :Targets, 'The targets for this asset', 0..1
  end
  
  type :AssetArchetypeRef, 'A reference to the archetype' do
    attribute :'xlink:href', 'Reference to the file', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
    member :AssetType, 'The type of asset that changed', 0..1, :AssetAttrType
    member :AssetId, 'The architype id reference'
  end
  
  type :AssetArchetypeRefs, 'Parent assets architype references' do
    member :AssetArchetypeRef, 'A reference to the parent', 1..INF
  end
    
  type :AssetArchetype, 'An abstract asset archetype', :Asset do
    member :ParentAssetArchetypeRef, 'Parent assset references', 0..1, :AssetArchetypeRef
    member :Description, 'The description of the file (freeform)', 0..1, :AssetDescription
    member :Targets, 'The targets for this asset', 0..1
  end
  
  
  type :AssetRef, 'A reference to an asset' do
    attribute :'xlink:href', 'Reference to the file', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
    member :AssetType, 'The type of asset that changed', 0..1, :AssetAttrType
    member :AssetId, 'The architype id reference'
  end
  
  type :AssetRefs, 'Asset  references' do
    member :AssetRef, 'A reference to the asset', 1..INF
  end
  
  type :Targets, 'A list of target devices or locations' do
    member :Target, 'Where this process step will be done', 1..INF
  end
  
  enum :TargetTypeValue, 'The set of possible locations' do
    value :EXTERNAL, 'The step will be performed outside this facility'
    value :STOCK, 'The step will involve only manipulation of raw material'
    value :INVENTORY, 'The part or material will be placed in storage'
    value :QUEUE, 'The part or material will be placed in a queue'
    value :DEVICE, 'The target is a device'
  end
  
  basic_type :TargetDevice, 'The target value. For a device it is the UUID, for a location it is a description or UUID'
  basic_type :TargetLocation, 'The target value. For a device it is the UUID, for a location it is a description or UUID'
  
  attr :TargetId, 'The identifier of the target', :NMTOKEN
  attr :TargetIdRef, 'The identifier of the target', :NMTOKEN
  
  type :Target, 'The device or location something can be done at' do    
    member :TargetId, 'The identifier of this target', 1
    member :Name, 'The identifier of this target', 0..1
    member :Type, 'The type of the target', :TargetTypeValue
    choice do
      member :TargetDevice, 'The  deviceidentifier or description'
      member :TargetLocation, 'The location identifier or description'
    end
  end
  
  type :TargetGroups, 'A set of groups of target references' do
    member :TargetGroup, 'A reference to a target', 1..INF
  end
  
  attr :TargetGroupId, 'An identifier for a target group', :NMTOKEN
  attr :TargetGroupIdRef, 'An identifier for a target group', :NMTOKEN
  type :TargetGroup, 'A group of targets' do
    member :Description, 'The description of the target group', 0..1, :AssetDescription
    member :TargetGroupId, 'The identifier of this target', 1
    member :TargetRef, 'A reference to a target', 1..INF
  end
  
  type :TargetRef, 'A reference to a target' do
    member :TargetIdRef, 'The identifier of this target', 1
  end
  type :TargetGroupRef, 'A reference to a target' do
    member :TargetGroupIdRef, 'The identifier of this target', 1
  end
  
end