
package :MobileAssets, 'Mobile Assets' do
  
  basic_type :Description, 'A description'
  basic_type :PotCount, 'The number of pots (Is this term confusing?)', :integer
  attr :InsertId, 'An identifier for the insert', :integer
  basic_type :MeasurementValue, 'A measurement value', :float
  attr :Maximum, 'A maximum value', :float
  attr :Minimum, 'A minimum value', :float  
  
  enum :ToolStateValue, 'The state of the tool' do
    value :FRESH, 'The tool is new'
    value :EXPIRED, 'The tool is dead'
    value :NOT_REGISTERED, ' An unregisterd state'
    value :IN_USE, 'The tool is currently being used'
    value :BROKEN, 'The tool is broken'
  end
  
  enum :MeasurementType, 'The type of measurement' do
    value :NOMINAL, 'The nominal value'
    value :MEASURED, 'The measured value'
    value :OFFSET, 'An offset'
  end
  
  type :ToolState, 'The tool state' do
    member :Value, 'The state', :ToolStateValue
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :Name, 'The name of the asset'
    member :SerialNumber, 'The serial number of the asset'
    member :Description, 'The description of the asset (freeform)', 0..1
  end
  
  type :MobileAssets, 'The collection of mobile assets' do
    choice(1..INF) do
      member :ToolAssembly, 'A tool assembly'
      member :Workholding, 'A workholding definition (TBD)'
    end
  end
  
  type :Workholding, 'Currently just a place holder', :Asset do
  end
  
  type :ToolAssembly, 'A defintion of a cutting implement', :Asset do
    member :ToolState, 'The state of the tool assembly'
    member :PotCount, 'The number of pots this tool will consume due to interference. If not given, assume 1', 0..1 do
      self.default = 1
    end
    member :Inserts, 'A list of inserts for this assembly'
  end
  
  type :Inserts, 'A list of inserts' do
    member :Insert, 'An insert', 1..INF
  end
  
  type :Insert, 'An insert into a tool assembly' do
    member :InsertId, 'The unique identifier of this insert in this assembly'
    member :InsertMeasurement, 'An insert measurement', 1..INF
  end
  
  type :InsertMeasurement, 'An abstract type for insert measurements' do
    abstract
    member :Type, 'The type of measurement', :MeasurementType
    member :Maximum, 'The maximum value', 0..1
    member :Minimum, 'The minimum value', 0..1
    member :Value, 'The measurement', :MeasurementValue
  end
  
  type :Length, 'A length', :InsertMeasurement
  type :Diameter, 'A diameter', :InsertMeasurement
  type :TipAngle, 'A tip angle', :InsertMeasurement
  type :CornerRadius, 'A corner radius', :InsertMeasurement
  type :Life, 'A life', :InsertMeasurement
end