package :Specificaitons, 'Device and component specificaitons' do
  basic_type :LimitValue, 'The limit of a value', :float
  attr :Peak, 'The peak value', :float


  # Specifications
  type :Specifications, 'Calibration data for a sensor', :AbstractConfiguration do
    member :Specification, 'A Specification', 1..INF, :AbstractSpecification
  end

  enum :OriginatorEnum, 'A reference to the creator of the Specification' do
    extensible
    value :MANUFACTURER, 'The manufacturer of a piece of equipment or component.'
    value :USER, 'The owner or implementer of a piece of equipment or component.'
  end

  type :AbstractSpecification, 'A specification' do
    abstract    
    member :Id, 'The identity of the Specificaiton', :ID
    member :Type, 'The type of measurement', :DataItemEnum
    member(:Originator, 'A reference to the creator of the Specification', 0..1, :OriginatorEnum) { self.default = 'MANUFACTURER' }
    member :SubType, 'The type of measurement', 0..1, :DataItemSubEnum
    member :Name, 'The name of the spec', 0..1
    member :DataItemIdRef, 'The optional data item identifier', 0..1, :SourceDataItemId
    member :CompositionIdRef, 'The optional composition identifier', 0..1, :CompositionId
    member :CoordinateSystemIdRef, 'The optional coordinate system identifier', 0..1
    member :Units, 'The units', 0..1
  end
  
  type :Specification, 'A specification', :AbstractSpecification do
    member :Maximum, 'A numeric upper constraint.', 0..1
    member :Minimum, 'A numeric lower constraint.', 0..1
    member :Nominal, 'The ideal or desired value for a variable', 0..1
    member :UpperLimit, 'The upper conformance boundary for a variable', 0..1
    member :UpperWarning, 'The upper boundary indicating increased concern and supervision may be required', 0..1
    member :LowerWarning, 'The lower boundary indicating increased concern and supervision may be required', 0..1
    member :LowerLimit, 'The lower conformance boundary for a variable', 0..1
  end

  type :Constraint, 'The limit of a constraint' do
    abstract
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
    member :ControlLimits, "The control limits", 0..1
    member :AlarmLimits, "The control limits", 0..1
    member :SpecificationLimits, "The control limits", 0..1
  end

  type :ControlLimits, 'A set of limits used to indicate whether a process variable is stable and in control.' do
    member :UpperLimit, 'upper limit', 0..1
    member :UpperWarning, 'upper warning', 0..1
    member :Nominal, 'nominal', 0..1
    member :LowerWarning, 'lower warning', 0..1
    member :LowerLimit, 'lower limit', 0..1
  end

  type :AlarmLimits, 'A set of limits used to trigger warning or alarm indicators' do
    member :UpperLimit, 'upper limit', 0..1
    member :UpperWarning, 'upper warning', 0..1
    member :LowerWarning, 'lower warning', 0..1
    member :LowerLimit, 'lower limit', 0..1
  end
  
  type :SpecificationLimits, 'A set of limits used to trigger warning or alarm indicators' do
    member :UpperLimit, 'upper limit', 0..1
    member :Nominal, 'nominal', 0..1
    member :LowerLimit, 'lower limit', 0..1
  end
end


