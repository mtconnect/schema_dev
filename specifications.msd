package :Specificaitons, 'Device and component specificaitons' do
  basic_type :LimitValue, 'The limit of a value', :float
  attr :Peak, 'The peak value', :float

  basic_type :ConstraintValue, 'The value of the constraint'

  # Specifications
  type :Specifications, 'Calibration data for a sensor', :AbstractConfiguration do
    member :Specification, 'A Specification', 1..INF, :AbstractSpecification
  end

  type :AbstractSpecification, 'A specification' do
    mixed
    abstract
  end
  
  type :Capability, 'A specification', :AbstractSpecification do
    mixed
    member :Type, 'The type of measurement', :DataItemEnum
    member :CompositionId, 'The optional composition identifier', 0..1
    member :DataItemId, 'The optional data item identifier', 0..1, :SourceDataItemId
    member :Constraint, 'The set of constraints', 1..INF
    member :Units, 'The units', 0..1
  end

  type :Constraint, 'an abstract constraint' do
    abstract
    mixed
  end
    
  type :ConstraintLimit, 'The limit of a constraint', :Constraint do
    member :Value, 'The limit value', :LimitValue
  end
  
  type :Maximum, 'The maximum value', :ConstraintLimit  
  type :Minimum, 'The minimum value', :ConstraintLimit    
  type :Nominal, 'The nominal value', :ConstraintLimit
  type :Rated, 'The value of the constraint', :ConstraintLimit
  
  type :DutyCycle, 'The duty cycle', :Constraint do
    mixed
    member :Duration, 'The duration of the duty cycle', :DurationTime
    member :Peak, 'The peak value of the duty cycle', :LimitValue
    member :Value, 'The duty cycle', :LimitValue
  end

  attr :GearNumber, 'The number of the gear', :integer
  basic_type :GearRatio, 'The ratio for the gear', :float

  type :GearSpecification, 'A power transmission gearing, ratio given as CDATA', :Constraint do
    member :Number, 'The gear number', :GearNumber
  end

  # Motion 
  enum :MotionTypeEnum, 'The types of motion' do
    value :REVOLUTE, 'Rotates'
    value :PRISMATIC, 'Linear motion'
    value :TWIST, 'Twister'
    value :REVOLVE, 'Revolver'
  end  
  
  type :AxisOfMotion, 'The axis motion types', :AbstractSpecification do
    member :Type, 'The motion type', :MotionTypeEnum
    member :Value, 'The axis motion', :ThreeSpaceValue
  end


  enum :CoordinateSystemTypeEnum, 'The type of coordinate system' do
    value :WORLD, 'The world'
    value :BASE, 'The base of the manipulator chain'
    value :TOOL, 'The tool\'s coord'
    value :WORKPIECE, 'The workpiece'
    value :OBJECT, 'The object'
    value :TASK, 'The current task'
    value :MECHANICAL_INTERFACE, 'The last joint in the chain'
    value :GRIPPER, 'The gripper'
    value :MOBILE_PLATFORM, 'The platform'
    value :JOINT, 'A given joint (kinematic should be true)'
  end

  attr :IsKinematic, 'Flag indicating if a coordinate system is part of a kinematic chain', :boolean

  # Coordinate Systems
  type :CoordinateSystem, 'Specifies a coordinate system with a location or offset', :AbstractSpecification do
    mixed
    member :Id, 'The coordinate system identifier', :ID
    member(:Kinematic, 'Boolean flag indicating if this is a kinematic coordinate system', 0..1, :IsKinematic) { self.default = 'false' }
    member :Name, 'The optional name of the coordinate system', 0..1
    member :Parent, 'The parent of the coordinate system', 0..1, :IdRef
    member :Type, 'The coordinate system type', :CoordinateSystemTypeEnum
    choice do
      member :Location, 'The location (no parent)'
      member :Transformation, 'A six space trasformaton from the parent'
    end
  end
    
  type :Location, 'A six space location in space' do
    member :Value, 'The location', :ThreeSpaceValue
  end

  type :Transformation, 'An offset in space' do
    member :Translaton, 'An offset applied first', :ThreeSpaceValue
    member :Rotation, 'A quaternion transform applied second', :ThreeSpaceValue
  end
           

  # Relationships
  type :Relationships, 'A set of relationships', :AbstractConfiguration do
    member :Relationship, 'A relationship', 1..INF
  end

  enum :AssociationEnum, 'The list of possible association types' do
    value :PARENT, 'The related entity is a parent'
    value :CHILD, 'The related entity is a child'
    value :PEER, 'The related entity is a peer'
  end

  type :Relationship, 'A relationship between this component and something else' do
    abstract
    member :Name, 'The optional name of the relationship', 0..1
    member :Association, 'The assciation type', :AssociationEnum
  end
  
  type :DeviceRelationship, 'A relationship to a device', :Relationship do
    member :DeviceUuidRef, 'A reference to the device uuid', :Uuid
    attribute :href, 'Reference to the url of the related device', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href fixed at located', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end

  type :ComponentRelationship, 'A relationship to a device', :Relationship do
    member :ComponentIdRef, 'A reference to the device uuid', :IdRef
  end
end
