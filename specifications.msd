package :Specificaitons, 'Device and component specificaitons' do
  attr :LimitValue, 'The limit of a value', :float
  attr :Peak, 'The peak value', :float  
  
  basic_type :ConstraintValue, 'The value of the constraint'
  
  type :Specifications, 'Calibration data for a sensor', :AbstractConfiguration do
    member :Specification, 'A Specification', 1..INF
  end
  
  type :Specification, 'A specification' do
    member :Type, 'The type of measurement', :DataItemEnum
    member :id, 'The data item identifier', :ID
    member :CompositionId, 'The optional composition identifier', 0..1
    member :DataItemId, 'The optional data item identifier', 0..1, :SourceDataItemId
    member :Constraint, 'The set of constraints', 1..INF
  end

  type :Constraint, 'an abstract constraint' do
    abstract
    member :Units, 'The units', 0..1
    member :Value, 'The value', :ConstraintValue
  end
    
  type :ConstraintLimit, 'The limit of a constraint', :Constraint do
    member :Value, 'The limit value', :LimitValue
  end
  
  type :Maximum, 'The maximum value', :ConstraintLimit  
  type :Minimum, 'The minimum value', :ConstraintLimit    
  type :Nominal, 'The nominal value', :ConstraintLimit
  type :Value, 'The value of the constraint', :ConstraintLimit
  
  type :DutyCycle, 'The duty cycle', :Constraint do 
    member :Duration, 'The duration of the duty cycle', :DurationTime
    member :Peak, 'The peak value of the duty cycle', :LimitValue
    member :Value, 'The duty cycle', :LimitValue
  end
  
end