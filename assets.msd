
package :Assets, 'Mobile Assets' do
  
  basic_type :Description, 'A description'
  basic_type :Size, 'The number of pots (Is this term confusing?)', :integer
  basic_type :Weight, 'The number of pots (Is this term confusing?)', :integer
  basic_type :EdgeCount, 'The number of cutting edges', :integer
  basic_type :PocketId, 'An identifier for the insert', :integer
  basic_type :Connection, 'The connection to the machine tool'
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :SettingGuage, 'The setting guage'
  attr :ToolId, 'The unique identifier of the tool type'
  
  attr :ToolLifeValue, 'The life of the tool in seconds?', :float
  attr :EdgeId, 'An identifier for the insert', :integer
  attr :MeasurementValue, 'A measurement value', :float
  attr :Maximum, 'A maximum value', :float
  attr :Minimum, 'A minimum value', :float  
  
  enum :ToolStatusValue, 'The state of the tool' do
    value :NEW, 'The tool is new'
    value :NOT_REGISTERED, ' An unregisterd state'
    value :RECONDITIONED, 'The tool is being reconditioned'
    value :USED,'The tool is used'
    value :EXPIRED, 'The tool is dead'
    value :TAGGED_OUT, 'The tool is currently out being reconditioned or sharpened'
    value :BROKEN, 'The tool is broken'
  end
  
  enum :OrientationAssembly, 'The orientation of the curring tool' do
    value :LEFT, 'A left oriented tool'
    value :RIGHT, 'A right oriented tool'
    value :BOTH, '????'
  end

  enum :OrientationDevice, 'The orientation of the cutting tool relative machine tool' do
    value :LEFT, 'A left oriented tool'
    value :RIGHT, 'A right oriented tool'
    value :BOTH, '????'
  end
  
  enum :ToolLifeDirection, 'The direction of tool life count' do
    value :UP, 'The tool life counts up from the 0 to maximum'
    value :DOWN, 'The tool life counts down from maximum to 0'
  end
  
  enum :ToolLifeType, 'The direction of tool life count' do
    value :TIME, 'The tool life measured in minutes'
    value :PART_COUNT, 'The tool life measured in parts made'
    value :WEAR, 'The tool life measured in wear'
  end
  
  enum :ToolType, 'The type of the tool' do
    value :SHELL_MILL, 'Shell mill'
    value :END_MILL, 'End mill'
  end

  enum :OperationType, 'The type of the tool' do
    value :MILLING, 'Milling tool'
    value :END_MILLING, 'End Milling tool'
    value :FACE_MILLING, 'End Milling tool'
    value :BALL_MILLING, 'End Milling tool'
    value :DRILLING, 'Drilling tool'
    value :REAMING, 'Reaming tool'
    value :TAPPING, 'Tapping tool'
    value :BROACHING, 'Broaching tool'
    value :LINEAR_BROACHING, 'Linear Broaching tool'
    value :CIRCULAR_BROACHING, 'Circular Broaching tool'
  end
      
  type :Assets, 'The collection of mobile assets' do
    choice(1..INF) do
      member :Asset, 'A tool assembly'
    end
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :AssetId, 'The unique identifier of the asset - may be same as serial number (should we remove serial number?)'
    member :SerialNumber, 'The serial number of the asset'
    member :Description, 'The description of the asset (freeform)', 0..1
    member :Timestamp, 'The time asset information was recorded'
  end
      
  type :CuttingTool, 'A defintion of a cutting implement', :Asset do
    # Identification
    member :ToolId, 'The Identifier of the tool type'
    element :ToolType, 'The type of the tool'
    element :OperationType, 'The operation type of the tool'
    
    # Status
    element :Status, 'The state of the tool assembly', 0..1, :ToolStatusValue
    member :ToolLife, 'The life of a tool assembly', 0..3, :Life
    
    # Connection
    member :PocketId, 'The pocket location', 0..1
    member :Connection, 'The connection to the spindle or ...', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :Size, 'The number of pots this tool will consume due to interference. If not given, assume 1', 0..1 do
      self.default = 1
    end
    member :Weight, 'The wieght of the tool (Pocket Usage)', 0..1
    element :OrientationAssembly, 'The orientation with respect to the assembly (need more info)', 0..1
    element :OrientationDevice, 'The orientation with respect to the device(need more info)', 0..1
    member :SettingGuage, 'The setting guage', 0..1
    
    # Geometry
    member :Length, 'The length of the tool assembly', 0..1
    member :Diameter, 'The diameter of the tool assembly', 0..1

    # Edges
    member :EdgeCount, 'The number of cutting edges'
    member :Edges, 'A list of edges for this assembly'
  end
  
  type :Life, 'Abstract cutter life' do 
    member :Type, 'One of time, part count, or wear', 1, :ToolLifeType
    member :Direction, 'The count up or count down', 1, :ToolLifeDirection
    member :Warning, 'Tool life warning level', 0..1, :ToolLifeValue
    member :Maximum, 'Maximum tool life', 1, :ToolLifeValue
    member :Value, 'The current tool life', :ToolLifeValue
  end
    
  type :Edges, 'A list of edge' do
    member :Edge, 'An edge', 1..INF
  end
    
  type :Edge, 'An edge into a tool assembly' do
    member :EdgeId, 'The unique identifier of this insert in this assembly'      
    member :Length, 'The length of the edge', 0..1
    member :Diameter, 'The diameter of the edge', 0..1
    member :TipAngle, 'The angle of the tool cutting edge', 0..1
    member :CornerRadius, 'The angle of the tool cutting edge', 0..1
    member :EdgeLife, 'The life of an edge', 0..1, :Life
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
end