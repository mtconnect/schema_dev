# Version 1.7

package :Motion, 'Motion represents kinematics' do
    # Motion 
  enum :MotionTypeEnum, 'The types of motion' do
    value :REVOLUTE, 'Rotates around an axis with a fixed range of motion'
    value :CONTINUOUS, 'Revolves around an axis with a continuous range of motion'
    value :PRISMATIC, 'Sliding linear motion along an axis with a fixed range of motion'
    value :FIXED, 'The axis does not move.'
  end

  enum :ActuationTypeEnum, 'The actuation of this component' do
    value :DIRECT, 'The movement is initiated by the component.'
    value :VIRTUAL, 'The motion is computed and is used for expressing an imaginary movement.'
    value :NONE, 'There is no actuation of this Axis.'
  end

  type :MotionAxis, 'The unit vector along which the motion occurs' do
    value 'The unit of motion', :ThreeSpaceValue    
  end

  type :MotionDescription, 'The description of the motion' do
    mixed
    member :any, 'Any elements', 0..INF
  end  
  
  
  type :Motion, 'The axis motion types', :AbstractConfiguration do
    mixed
    ordered
    member :Id, 'The coordinate system identifier', :ID
    member :ParentIdRef, 'The parent of the coordinate system', 0..1, :IdRef
    member :CoordinateSystemIdRef, 'The identifier of the coordinate system that this motion is relative to'
    member :Type, 'The motion type', :MotionTypeEnum
    member :Actuation, 'The actuation method', :ActuationTypeEnum
    member :Description, 'The description of the motion', 0..1, :MotionDescription
    choice(0..1) do
      member :Origin, 'The location (no parent)'
      member :Transformation, 'A rotation and translation'
    end
    member :Axis, 'The axis motion', :MotionAxis
  end
end
