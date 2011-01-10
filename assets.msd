
package :Assets, 'Mobile Assets' do
  
  basic_type :Description, 'A description'
  basic_type :Size, 'The number of pots (Is this term confusing?)', :integer
  basic_type :Weight, 'The number of pots (Is this term confusing?)', :integer
  basic_type :CuttingEdges, 'The number of cutting edges', :integer
  basic_type :PocketId, 'An identifier for the insert', :integer
  basic_type :Connection, 'The connection to the machine tool'
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :Orientation, 'The orientation of this tool'
  basic_type :SettingGuage, 'The setting guage'
  
  attr :ToolLifeValue, 'The life of the tool in seconds?', :float
  attr :EdgeId, 'An identifier for the insert', :integer
  attr :MeasurementValue, 'A measurement value', :float
  attr :Maximum, 'A maximum value', :float
  attr :Minimum, 'A minimum value', :float  
  
  enum :ToolStatusValue, 'The state of the tool' do
    value :FRESH, 'The tool is new'
    value :EXPIRED, 'The tool is dead'
    value :NOT_REGISTERED, ' An unregisterd state'
    value :IN_USE, 'The tool is currently being used'
    value :BROKEN, 'The tool is broken'
  end
      
  type :Assets, 'The collection of mobile assets' do
    choice(1..INF) do
      member :Asset, 'A tool assembly'
    end
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :AssetId, 'The Identifier of the asset'
    member :SerialNumber, 'The serial number of the asset'
    member :Description, 'The description of the asset (freeform)', 0..1
    member :Timestamp, 'The time asset information was recorded'
  end
      
  type :ToolAssembly, 'A defintion of a cutting implement', :Asset do
    member :Connection, 'The connection to the spindle or ...'
    member :ProgramToolNumber, 'The number used to identify this tool in the program'
    member :ToolStatus, 'The state of the tool assembly', :ToolStatusValue
    member :Size, 'The number of pots this tool will consume due to interference. If not given, assume 1', 0..1 do
      self.default = 1
    end
    member :Weight, 'The wieght of the tool (Pocket Usage)', 0..1
    member :ToolLife, 'The life of a tool'
    member :CuttingEdges, 'The number of cutting edges'
    member :PocketId, 'The pocket location'
    member :Orientation, 'The orientation (need more info)'
    member :SettingGuage, 'The setting guage'
    
    member :Edges, 'A list of edges for this assembly'
  end
  
  type :ToolLife, 'The life of the tool' do
    member :Maximum, 'Maximum tool life', 0..1, :ToolLifeValue
    member :Value, 'The life', :ToolLifeValue
  end
  
  type :Edges, 'A list of edge' do
    member :Edge, 'An edge', 1..INF
  end
    
  type :Edge, 'An edge into a tool assembly' do
    member :EdgeId, 'The unique identifier of this insert in this assembly'
    member :EdgeMeasurement, 'An insert edge', 1..INF
  end
  
  type :EdgeMeasurement, 'An abstract type for edge measurements' do
    abstract
    member :Maximum, 'The maximum tolerance value', 0..1, :MeasurementValue
    member :Minimum, 'The minimum tolerance value', 0..1, :MeasurementValue
    member :Nominal, 'The nominal value', 0..1, :MeasurementValue
    member :Value, 'The actual measurement', :MeasurementValue
  end
  
  type :Length, 'A length', :EdgeMeasurement do
    member :Wear, 'The wear value', 0..1, :MeasurementValue
    member :Value, 'The actual measurement', :MeasurementValue
  end
  type :Diameter, 'A diameter', :EdgeMeasurement do 
    member :Wear, 'The wear value', 0..1, :MeasurementValue
    member :Value, 'The actual measurement', :MeasurementValue
  end
  
  type :TipAngle, 'A tip angle', :EdgeMeasurement
  type :CornerRadius, 'A corner radius', :EdgeMeasurement
  type :Life, 'A life', :EdgeMeasurement
end