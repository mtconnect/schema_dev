package :CoordinateSystems, 'Coordinate systems, kinematics and motion' do
  # Motion 
  enum :MotionTypeEnum, 'The types of motion' do
    value :REVOLUTE, 'Rotates'
    value :PRISMATIC, 'Linear motion'
    value :TWIST, 'Twister'
    value :REVOLVE, 'Revolver'
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
    value :PLATFORM, 'The platform'
    value :JOINT, 'A given joint'
    value :MACHINE, 'For machine tools, the coordinate system in the work area'
  end

  enum :ActuationTypeEnum, 'The actuation of this component' do
    value :DIRECT, 'The motion is directly controller'
    value :DERIVATIVE, 'The motion is created by an unpowered linkage, can be a calculated value'
    value :VIRTUAL, 'The component provide a logical position'
    value :FIXED, 'The position is fixed in space, it does not move'
  end

  enum :GeometryTypeEnum, 'The geometry related to this coordinate system' do
    value :CARTESIAN, 'The coordinate system uses cartesian coordinates'
    value :POLAR, 'The positions will be given in polar coordinates'
    value :CYLINDRICAL, 'The positions are given in cylindrical coordinates'
  end

  attr :IsKinematic, 'Flag indicating if a coordinate system is part of a kinematic chain', :boolean

  type :Link, 'A linkage between two axes', :Axes
  type :Table, 'A linkage between two axes', :CommonComponent

  # Coordinate Systems
  type :CoordinateSystems, 'A collection of coordinate systems', :AbstractConfiguration do
    mixed
    member :CoordinateSystem, 'A coordinate system', 1..INF
  end

  type :MotionOrigin, 'A translation and rotation of a new origin of motion' do
    member :Translation, 'An offset applied first', 0..1, :ThreeSpaceValue
    member :Rotation, 'A angluar rotation applied second', 0..1, :ThreeSpaceValue
  end
  
  type :CoordinateSystem, 'Specifies a coordinate system with a location or offset' do
    member :Id, 'The coordinate system identifier', :ID
    member(:Geometry, 'The geometry used in this coordinate system', 0..1, :GeometryTypeEnum) { self.default = 'CARTESIAN' }
    member :Name, 'The optional name of the coordinate system', 0..1
    member :ParentId, 'The parent of the coordinate system', 0..1, :IdRef
    member :MotionIdRef, 'If this coordinate system represents a montion frame for a component', 0..1, :IdRef
    member :Type, 'The coordinate system type', :CoordinateSystemTypeEnum
    choice(0..1) do
      member :Location, 'The location (no parent)'
      set do 
        member :Translation, 'An offset applied first', 0..1, :ThreeSpaceValue
        member :Rotation, 'A angluar rotation applied second', 0..1, :ThreeSpaceValue
      end
    end
  end

  type :Location, 'A six space location in space' do
    member :Value, 'The location', :ThreeSpaceValue
  end

  type :Transformation, 'An offset in space' do
    member :Translaton, 'An offset applied first', :ThreeSpaceValue
    member :Rotation, 'A quaternion transform applied second', :ThreeSpaceValue
  end             

  type :MotionAxis, 'The unit vector along which the motion occurs' do
    value 'The unit of motion', :ThreeSpaceValue    
  end
  
  type :Motion, 'The axis motion types', :AbstractConfiguration do
    mixed
    member :Id, 'The coordinate system identifier', :ID
    member :KinematicParentIdRef, 'The parent of the coordinate system', 0..1, :IdRef
    member :CoordinateSystemId, 'The identifier of the coordinate system that this motion is relative to'
    member :Type, 'The motion type', :MotionTypeEnum
    member :Actuation, 'The actuation method', :ActuationTypeEnum
    member :Origin, 'The axis motion', 0..1, :MotionOrigin
    member :Axis, 'The axis motion', 0..1, :MotionAxis
  end
end

