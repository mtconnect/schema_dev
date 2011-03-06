
package :Assets, 'Mobile Assets' do
  basic_type :PocketSize, 'The number of pots (Is this term confusing?)', :integer
  basic_type :PocketId, 'An identifier for the insert'
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :SettingGuage, 'The setting guage'
  basic_type :Offset, 'The offset of the tool', :float
  basic_type :ReconditionCount, 'The number of times the cutter has been reconditioned'
  basic_type :PocketWeight, 'The weight of the cutter in kg'
  
  attr :ToolId, 'The unique identifier of the tool type'
  attr :EdgeCount, 'The number of cutting edges', :integer
  attr :ToolLifeValue, 'The life of the tool in seconds?', :float
  attr :ItemId, 'An identifier for the insert', :integer
  attr :MeasurementValue, 'A measurement value', :float
  attr :Maximum, 'A maximum value', :float
  attr :Minimum, 'A minimum value', :float  

  enum :DefinitionFormat, 'The format of the definition' do
    value :EXPRESS, 'The definition will be provided in EXPRESS format'
    value :XML, 'The definition will be provided in XML'
    value :TEXT, 'The definition will be provided in uninterpreted TEXT'
    value :UNDEFINED, 'The definition will be provided in an unspecified format'
  end
    
  enum :CutterStatusValue, 'The state of the tool' do
    value :NEW, 'The tool is new'
    value :NOT_REGISTERED, ' An unregisterd state'
    value :RECONDITIONED, 'The tool is being reconditioned'
    value :USED,'The tool is used'
    value :EXPIRED, 'The tool is dead'
    value :TAGGED_OUT, 'The tool is currently out being reconditioned or sharpened'
    value :BROKEN, 'The tool is broken'
  end
    
  enum :ToolLifeDirection, 'The direction of tool life count' do
    value :UP, 'The tool life counts up from the 0 to maximum'
    value :DOWN, 'The tool life counts down from maximum to 0'
  end
  
  enum :ToolLifeType, 'The direction of tool life count' do
    value :MINUTES, 'The tool life measured in minutes'
    value :PART_COUNT, 'The tool life measured in parts made'
    value :WEAR, 'Measurement of tool life in tool wear'
  end
  
  type :AssetDescription, 'The description of an asset, can be freeform text or elemenrts' do
    mixed
    member :any, 'Any elements', 0..INF
  end  
  
  type :CuttingToolDefinition, 'The description of an asset, can be freeform text or elemenrts' do
    mixed
    member :format, 'The format of the data in the definition', 0..1, :DefinitionFormat do
      default = 'XML'
    end
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
    member :Description, 'The description of the asset (freeform)', 0..1, :AssetDescription
    member :Timestamp, 'The time asset information was recorded'
  end
  
  type :CuttingTool, 'A cutting tool', :Asset do
    member :DeviceUuid, 'The uuid this tool is associated with', 0..1, :Uuid
    member :ToolId, 'The Identifier of the tool type'
    
    at_least_one do 
      member :CuttingToolDefinition, 'Description of tool'
      member :CuttingToolLifeCycle, 'the tool lifecycle'
    end
  end
      
  type :CuttingToolLifeCycle, 'A defintion of a cutting tool application and life cycle' do
    # Identification
    # Status
    element :CutterStatus, 'The state of the tool assembly', 0..1, :CutterStatusValue
    member :ToolLife, 'The life of a tool assembly', 0..3, :Life
    member :ReconditionCount, 'The number of times the cutter has been reconditioned', 0..1
    
    # Connection
    member :PocketId, 'The pocket location', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :PocketSize, 'The number of pots this tool will consume due to interference. If not given, assume 1', 0..1 do
      self.default = 1
    end
    member :PocketWeight, 'The weight of the cutter in kilograms', 0..1
    
    # Geometry
    member :Offset, 'The offset of the tool assembly', 0..1
    member :Length, 'The length of the tool assembly', 0..1
    member :Diameter, 'The diameter of the tool assembly', 0..1

    # Edges
    member :CuttingItems, 'A list of edges for this assembly', 0..1
  end
  
  
  type :Life, 'Abstract cutter life' do 
    member :Type, 'One of time, part count, or wear', 1, :ToolLifeType
    member :Direction, 'The count up or count down', 1, :ToolLifeDirection
    member :WarningLevel, 'Tool life warning level', 0..1, :ToolLifeValue
    member :Maximum, 'Maximum tool life', 1, :ToolLifeValue
    member :Value, 'The current tool life', :ToolLifeValue
  end
    
  type :CuttingItems, 'A list of edge' do
    member :Count, 'The number of edges', :EdgeCount
    member :CuttingItem, 'An edge', 1..INF
  end
    
  type :CuttingItem, 'An edge into a tool assembly' do
    member :ItemId, 'The unique identifier of this insert in this assembly'      
    member :Length, 'The length of the edge', 0..1
    member :Diameter, 'The diameter of the edge', 0..1
    member :TipAngle, 'The angle of the tool cutting edge', 0..1
    member :CornerRadius, 'The angle of the tool cutting edge', 0..1
    member :ItemLife, 'The life of an edge', 0..1, :Life
  end
  
  type :EdgeMeasurement, 'An abstract type for edge measurements' do
    abstract
    member :Maximum, 'The maximum tolerance value', 0..1, :MeasurementValue
    member :Minimum, 'The minimum tolerance value', 0..1, :MeasurementValue
    member :Nominal, 'The nominal value', 0..1, :MeasurementValue
    member :Value, 'The actual measurement', :MeasurementValue
  end
  
  type :Length, 'A length', :EdgeMeasurement
  type :Diameter, 'A diameter', :EdgeMeasurement
  type :TipAngle, 'A tip angle', :EdgeMeasurement
  type :CornerRadius, 'A corner radius', :EdgeMeasurement
  
end