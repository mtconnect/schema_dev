# Version 1.7

package :Motion, 'Motion represents kinematics' do
    # Motion 
  enum :MotionTypeEnum, 'The types of motion' do
    value :REVOLUTE, 'Rotates'
    value :PRISMATIC, 'Linear motion'
    value :TWIST, 'Twister'
    value :REVOLVE, 'Revolver'
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


  type :MotionOrigin, 'A translation and rotation of a new origin of motion' do
    member :Translation, 'An offset applied first', 0..1, :ThreeSpaceValue
    member :Rotation, 'A angluar rotation applied second', 0..1, :ThreeSpaceValue
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
