
package :Assets, 'Mobile Assets' do
  basic_type :LocationNumberValue, 'The tool location', :integer
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :ReconditionCountValue, 'The number of times the cutter has been reconditioned', :integer
  
  attr :LocationSize, 'The number of pots (Is this term confusing?)', :integer
  attr :ToolId, 'The unique identifier of the tool type'
  attr :EdgeCount, 'The number of cutting edges', :integer
  attr :ToolLifeValue, 'The life of the tool in seconds?', :float
  attr :ItemId, 'An identifier for the insert', :integer
  attr :MeasurementValue, 'A measurement value', :float
  attr :Minimum, 'A minimum value', :float  
  attr :Maximum, 'A maximum value', :float
  attr :Nominal, 'A nominal value', :float
  attr :Speed, 'A speed', :float
  attr :MaximumCount, 'A maximum count value', :integer
  attr :Code, 'A application specific code'
  
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
    value :UNKNOWN, 'The status of this cutter is undetermined'
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
  
  enum :LocationDirection, 'The positive or negative progression' do
    value :NEGATIVE, 'The tool occupies the pots at a smaller index'
    value :POSITIVE, 'The tool occupies the pots at a greater index'
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
    
  # Cutting tool definition
  type :CuttingTool, 'A cutting tool', :Asset do
    member :DeviceUuid, 'The uuid this tool is associated with', 0..1, :Uuid
    member :ToolId, 'The Identifier of the tool type'
    
    at_least_one do 
      member :CuttingToolDefinition, 'Description of tool'
      member :CuttingToolLifeCycle, 'the tool lifecycle'
    end
  end
  
  type :LocationNumber, 'The location of the tool in the tool changer (pot) or the station of the tool' do
    member :Size, 'The number of pots this tool will consume due to interference. If not given, assume 1', 0..1, :LocationSize do
      self.default = 1
    end
    member :Direction, 'The index direction of additional pots occupied by this', 0..1, :LocationDirection
    member :Value, 'The location', :LocationNumberValue
  end
  
  type :ReconditionCount, 'The number of times this tool has been reconditioned' do
    member :MaximumCount, 'The maximum number of times this tool can be reconditioned', 0..1
    member :Value, 'The number of times', :ReconditionCountValue
  end
  
  type :ProgramSpindleSpeed, 'The spindle speed properties of this tool' do
    member :Maximum, 'The maximum speed this tool may operate at', 0..1
    member :Minimum, 'The minimum speed this tool may operate at', 0..1
    member :Nominal, 'The nominal speed this tool may operate at', 0..1
    member :Value, 'The programmed tool spindle speed', 0..1, :Speed
  end
  
  # Define measurements for a cutting tool life cycle
  type :Measurement, 'An abstract type for edge measurements' do
    abstract
    member :Code, 'The shop or application specific code for this measurement', 0..1
    member :Maximum, 'The maximum tolerance value', 0..1, :MeasurementValue
    member :Minimum, 'The minimum tolerance value', 0..1, :MeasurementValue
    member :Nominal, 'The nominal value', 0..1, :MeasurementValue
    member :Value, 'The actual measurement', :MeasurementValue
  end
  
  type :CommonMeasurement, 'Measurements for both the assembly and the cutting item', :Measurement do
    abstract
  end
  type :AssemblyMeasurement, 'Measurements for the assembly', :Measurement do
    abstract
  end
  type :CuttingItemMeasurement, 'Measurements for the cutting item', :Measurement do
    abstract
  end

  type :AssemblyMeasurements, 'A collection of assembly measurements' do
    choice 1..INF do
      member :CommonMeasurement, 'Common measurements'
      member :AssemblyMeasurement, 'Assembly measurements'
    end
  end

  # Common
  type :ProtrudingLength, 'dimension from the yz-plane to the furthest point of the tool item or adaptive item measured in the -X direction', :CommonMeasurement
  type :Mass, 'The weight measured in grams', :CommonMeasurement
  
  # Assembly
  type :BodyDiameter, 'The largest diameter of the body of a tool item', :AssemblyMeasurement
  type :BodyLength, 'The distance measured along the X axis from that point of the item closest to the workpiece, including the cutting item for a tool item but excluding a protuding locking mechanism for an adaptive item, to either the front of the flange on a flanged body or the beginning of the connection interface feature on the machine side for cylindrical or prismatic shanks', :AssemblyMeasurement
  type :DepthOfCut, 'The maximum engagement of the cutting edge or edges with the workpiece measured perpendicular to the feed motion.'
  type :OverallLength, 'largest length dimension of the tool item including the master insert where applicable', :AssemblyMeasurement
  type :ShankDiameter, 'dimension of the diameter of a cylindrical portion of a tool item or an adaptive item that can participate in a connection', :AssemblyMeasurement
  type :ShankHeight, 'dimension of the height of a shank', :AssemblyMeasurement
  type :ShankLength, 'dimension of the length of a shank', :AssemblyMeasurement
  type :ShankWidth, 'dimension of the width of a shank', :AssemblyMeasurement
  type :UsableLength, 'The maximum length of a cutting tool that can be used in a particular cutting operation including the non-cutting portions of the tool.', :AssemblyMeasurement
    
  
  type :CuttingToolLifeCycle, 'A defintion of a cutting tool application and life cycle' do
    # Identification
    # Status
    element :CutterStatus, 'The state of the tool assembly', 1, :CutterStatusValue do
      self.default = :UNKNOWN
    end
    member :ReconditionCount, 'The number of times the cutter has been reconditioned', 0..1
    
    # Connection
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :LocationNumber, 'The pocket location', 0..1
    member :ProgramSpindleSpeed, 'The tools constraned programmed spindle speed', 0..1
    
    # Measurements
    member :Measurements, 'A set of measurements associated with the cutting tool', 0..1, :AssemblyMeasurements

    # Cutting Items
    member :CuttingItems, 'A list of edges for this assembly'
  end
  
  type :Life, 'Abstract cutter life' do 
    member :Type, 'One of time, part count, or wear', 1, :ToolLifeType
    member :CountDirection, 'The count up or count down', 1, :ToolLifeDirection
    member :WarningLevel, 'Tool life warning level', 0..1, :ToolLifeValue
    member :Maximum, 'Maximum tool life', 1, :ToolLifeValue
    member :Value, 'The current tool life', :ToolLifeValue
  end
  
  type :CuttingItemMeasurements, 'A collection of assembly measurements' do
    choice 1..INF do
      member :CommonMeasurement, 'Common measurements'
      member :CuttingItemMeasurement, 'Cutting Item measurements'
    end
  end
  
  # Cutting Item Measurements
  type :CuttingDiameter, 'diameter of a circle on which the defined point Pk of each of the master inserts is located on a tool item. The normal of the machined peripheral surface points towards the axis of the cutting tool.', :CuttingItemMeasurement
  type :CornerRadius, 'nominal radius of a rounded corner measured in the XY-plane', :CuttingItemMeasurement
  type :CuttingEdgeLength, 'theoretical length of the cutting edge of a cutting item over sharp corners', :CuttingItemMeasurement
  type :CuttingHeight, 'theoretical length of the cutting edge of a cutting item over sharp corners', :CuttingItemMeasurement
  type :CuttingReferencePoiint, 'the theoretical sharp point of the cutting tool from which the major functional dimensions are taken', :CuttingItemMeasurement
  type :FlangeDiameter, 'dimension between two parallel tangents on the outside edge of a flange', :CuttingItemMeasurement
  type :FunctionalWidth, 'distance between the cutting reference point and the rear backing surface of a turning tool or the axis of a boring bar', :CuttingItemMeasurement
  type :InclinationAngle, 'angle between the tool rake plane and a plane parallel to the xy-plane measured in the tool cutting edge plane', :CuttingItemMeasurement
  type :IncribedCircleDiameter, 'diameter of a circle to which all edges of a equilateral and round regular insert are tangental', :CuttingItemMeasurement
  type :PointAngle, 'angle between the major cutting edge and the same cutting edge rotated by 180 degrees about the tool axis', :CuttingItemMeasurement
  type :StepDiameterLength, 'length of a portion of a cutting tool that is related to the corresponding cutting diameter. The length is measured from the point "PK" of the corresponging diameter to the next projected point where the diameter starts to change', :CuttingItemMeasurement
  type :StepIncludedAngle, 'angle between a major edge on a step of a stepped tool and the same cutting edge rotated 180 degrees about ist tool axis', :CuttingItemMeasurement
  type :ToolCuttingEdgeAngle, 'angle between the tool cutting edge plane and the tool feed plane measured in a plane parallel the xy-plane', :CuttingItemMeasurement
  type :ToolLeadAngle, 'angle between the tool cutting edge plane and a plane perpendicular to the tool feed plane measured in a plane parallel the xy-plane', :CuttingItemMeasurement
  type :WiperEdgeLength, 'measure of the length of a wiper edge of a cutting item', :CuttingItemMeasurement
  type :FunctionalLength, 'distance from the gauge plane or from the end of the shank, if a gauge plane does not exist, to the cutting reference point determined by the main function of the tool', :CuttingItemMeasurement
  
      
  type :CuttingItems, 'A list of edge' do
    member :Count, 'The number of edges', :EdgeCount
    member :CuttingItem, 'An edge', 1..INF
  end
    
  type :CuttingItem, 'An edge into a tool assembly' do
    member :ItemId, 'The unique identifier of this insert in this assembly'      
    member :ItemLife, 'The life of an edge', 0..1, :Life
    
    # Measurements
    member :Measurements, 'A set of measurements associated with the cutting tool', 0..1, :CuttingItemMeasurements
  end
end