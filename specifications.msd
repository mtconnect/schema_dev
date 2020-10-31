package :Specificaitons, 'Device and component specificaitons' do
  basic_type :LimitValue, 'The limit of a value', :float
  attr :Peak, 'The peak value', :float


  # Specifications
  type :Specifications, 'Calibration data for a sensor', :AbstractConfiguration do
    member :Specification, 'A Specification', 1..INF, :AbstractSpecification
  end

  type :AbstractSpecification, 'A specification' do
    mixed
    abstract 
    member :Id, 'The identity of the Specificaiton', :ID
    member :Type, 'The type of measurement', :DataItemEnum
    member :SubType, 'The type of measurement', 0..1, :DataItemSubEnum
    member :Name, 'The name of the spec', 0..1
    member :DataItemIdRef, 'The optional data item identifier', 0..1, :SourceDataItemId
    member :CompositionIdRef, 'The optional composition identifier', 0..1, :CompositionId
    member :CoordinateSystemIdRef, 'The optional coordinate system identifier', 0..1
    member :Units, 'The units', 0..1
 end
  
  type :Specification, 'A specification', :AbstractSpecification do
    mixed
    member :SpecificationValue, 'The set of constraints', 1..INF
  end

  type :SpecificationValue, 'an abstract value for a specification' do
    abstract
    mixed
  end
    
  type :Constraint, 'The limit of a constraint', :SpecificationValue do
    member :Value, 'The limit value', :LimitValue
  end
  
  type :Maximum, 'A numeric upper constraint.', :Constraint  
  type :Minimum, 'A numeric lower constraint.', :Constraint    
  type :Nominal, 'The ideal or desired value for a variable', :Constraint
  type :UpperLimit, 'The upper conformance boundary for a variable', :Constraint
  type :UpperWarning, 'The upper boundary indicating increased concern and supervision may be required', :Constraint
  type :LowerWarning, 'The lower boundary indicating increased concern and supervision may be required', :Constraint
  type :LowerLimit, 'The lower conformance boundary for a variable', :Constraint

  type :ProcessSpecification, 'ProcessSpecification provides information used to assess the conformance of a variable to process requirements',
       :AbstractSpecification do
    mixed    
    member :ControlLimits, "The control limits", 0..1
    member :AlarmLimits, "The control limits", 0..1
    member :SpecificationLimits, "The control limits", 0..1
  end

  type :ControlLimits, 'A set of limits used to indicate whether a process variable is stable and in control.', :SpecificationValue do
    mixed
    member :UpperLimit, 'upper limit'
    member :UpperWarning, 'upper warning'
    member :Nominal, 'nominal'
    member :LowerWarning, 'lower warning'
    member :LowerLimit, 'lower limit'
  end

  type :AlarmLimits, 'A set of limits used to trigger warning or alarm indicators', :SpecificationValue do
    mixed
    member :UpperLimit, 'upper limit'
    member :UpperWarning, 'upper warning'
    member :LowerWarning, 'lower warning'
    member :LowerLimit, 'lower limit'
  end
  
  type :SpecificationLimits, 'A set of limits used to trigger warning or alarm indicators', :SpecificationValue do
    mixed
    member :UpperLimit, 'upper limit'
    member :Nominal, 'nominal'
    member :LowerLimit, 'lower limit'
  end


  
  # possibly for 1.7
#  type :Rated, 'The value of the constraint', :Constraint
   
#  type :DutyCycle, 'The duty cycle', :SpecificationValue do
#    mixed
#    member :Duration, 'The duration of the duty cycle', :DurationTime
#    member :Peak, 'The peak value of the duty cycle', :LimitValue
#    member :Value, 'The duty cycle', :LimitValue
#  end

#  attr :GearNumber, 'The number of the gear', :integer
#  basic_type :GearRatio, 'The ratio for the gear', :float

#  type :GearSpecification, 'A power transmission gearing, ratio given as CDATA', :SpecificationValue do
#    mixed
#    member :Number, 'The gear number', :GearNumber
#    member :GearRatio, 'The gear ratio'
#  end
end


