
package :Assets, 'Mobile Assets' do
  
  basic_type :Description, 'A description'
  basic_type :Size, 'The number of pots (Is this term confusing?)', :integer
  basic_type :Weight, 'The number of pots (Is this term confusing?)', :integer
  basic_type :PocketId, 'An identifier for the insert'
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :SettingGuage, 'The setting guage'
  basic_type :Offset, 'The offset of the tool', :float
  basic_type(:ConnectionForm, 'The form specification for the connection') { pattern '[A-Za-z0-9/&amp;]+' }
  basic_type :ConnectionSize, 'The size of the connection as specified by the standard', :integer
  
  attr :ToolId, 'The unique identifier of the tool type'
  attr :EdgeCount, 'The number of cutting edges', :integer
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
  
  enum :AssemblyOrientation, 'The orientation of the curring tool' do
    value :LEFT, 'A left oriented tool'
    value :RIGHT, 'A right oriented tool'
    value :BOTH, '????'
  end

  enum :DeviceOrientation, 'The orientation of the cutting tool relative machine tool' do
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

  
  basic_type(:StyleExt, 'An extension point for data item types') do
    pattern 'x:[A-Z]+'
  end
  
  enum :ConnectionStyle, 'The style of the connection' do
    extensible :StyleExt
    
    value :CV, ''
    value :BTKV, ''
    value :CVKV, '?'
    value :QC, ''
    value :KM, ''
    value :HSK, 'DIN 69893'
    value :DV, 'DIN 69871'
    value :BT, 'JIS 6339'
    value :KM, 'KM Style'
    value :VDI, 'DIN 69880'
    value :CAPTO, 'Sandvik'
    value :SQUARE, 'Square fixed'
    value :ROUND, 'Round fixed'
    
  end
  
  type :Connection, 'A connection' do
    element :Style, 'The connection style', :ConnectionStyle
    element :Size, 'The connection size', :ConnectionSize
    element :Form, 'The connection form', :ConnectionForm
  end
  
  basic_type(:TypeExt, 'A class extension') do
    pattern 'x:[A-Z_]+'
  end
  
  enum :Category, 'The high level classification' do
    extensible :TypeExt
    
    value :FIXED, 'Fixed tool'
    value :ROTATIONAL, 'Rotating tool'
  end
  
  enum :ToolClassificaitonType, 'The tool type, this is the level below the classification' do
    extensible :TypeExt
    
    value :SHELL_MILL, 'Fixed tool'
    value :END_MILL, 'Rotating tool'
  end
  
  enum :ToolClassificaitonSubType, 'The tool sub-type, this is the level below the classification' do
    extensible :TypeExt
    
    value :SHELL_MILL, 'Fixed tool'
    value :END_MILL, 'Rotating tool'
  end
  
  
  enum :Operation, 'The type of the tool (Application?)' do
    extensible :TypeExt
    
    value :MILLING, 'Milling tool'
    value :DRILLING, 'Drilling tool'
    value :REAMING, 'Reaming tool'
    value :TAPPING, 'Tapping tool'
    value :BROACHING, 'Broaching tool'
  end

  enum :SubOperation, 'The sub-type of operation' do
    extensible :TypeExt
    
    value :LINEAR, 'Linear broaching tool'
    value :CIRCULAR, 'Circular broaching tool'
    value :FACE, 'Face milling'
    value :END, 'End milling'
    value :BALL, 'Ball milling'
  end
    
  type :Classification, 'The tool classification' do
    element :Type, 'The type of tool', :ToolClassificaitonType
    element :SubType, 'The sub-type of tool', 0..1, :ToolClassificaitonSubType
    element :Operation, 'The operation performed by this tool'
    element :SubOperation, 'The sub-type of operation', 0..1
  end

  type :AssetDescription, 'The description of an asset, can be freeform text or elemenrts' do
    mixed
    member :any, 'Any elements', 0..INF
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
    member :DeviceUuid, 'The uuid this tool is associated with', 0..1, :Uuid
    member :ToolId, 'The Identifier of the tool type'
    member :Classification, 'The tools classification'
    
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
    element :AssemblyOrientation, 'The orientation with respect to the assembly (need more info)', 0..1
    element :DeviceOrientation, 'The orientation with respect to the device(need more info)', 0..1
    member :SettingGuage, 'The setting guage', 0..1
    
    # Geometry
    member :Length, 'The length of the tool assembly', 0..1
    member :Diameter, 'The diameter of the tool assembly', 0..1
    member :Offset, 'The offset of the tool assembly', 0..1

    # Edges
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
    member :Count, 'The number of edges', :EdgeCount
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