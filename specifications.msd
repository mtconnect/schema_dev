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
  
  type :Specification, 'A specification', :AbstractSpecification do
    mixed
    member :Type, 'The type of measurement', :DataItemEnum
    member :SubType, 'The type of measurement', 0..1, :DataItemSubEnum
    member :CompositionId, 'The optional composition identifier', 0..1
    member :DataItemId, 'The optional data item identifier', 0..1, :SourceDataItemId
    member :Constraint, 'The set of constraints', 1..INF
    member :Units, 'The units', 0..1
  end

  type :Capability, 'A capability', :Specification

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
    mixed
    member :Number, 'The gear number', :GearNumber
    member :GearRatio, 'The gear ratio'
  end
end


load 'coordinate_systems'
