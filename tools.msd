package :Tools, 'Cutting tools' do
  range = "(\\d+|\\d+-\\d+)(,(\\d+|\\d+-\\d+))*"
  
  float = '[+-]?\d+(\.\d+)?([Ee][+-]?\d+)?'
  optional_float = "#{float}|"
  
  basic_type :LocationValue, 'The tool location', :integer
  basic_type :ProgramToolNumber, 'The number referenced in the program for this tool', :integer
  basic_type :ReconditionCountValue, 'The number of times the cutter has been reconditioned', :integer
  basic_type :ConnectionCodeMachineSide, 'The code for the connection to the machine'
  basic_type :ProgramToolGroup, 'The tool group associated with the tool'
  basic_type(:Speed, 'A speed in RPM or mm/s') { pattern optional_float }
  basic_type(:MeasurementValue, 'A measurement value') { pattern optional_float }
  
  attr :LocationSize, 'The number of location units required to hold this tool', :integer
  attr :MeasurementAttr, 'A measurement value', :float
  attr :CuttingToolId, 'The tool identifier', :NMTOKEN
  attr :EdgeCount, 'The number of cutting edges', :integer
  attr :Overlap, 'The number of additional locations taken by a tool', :integer
  attr :ToolLifeValue, 'The life of the tool in time, wear, or parts', :float
  attr :ItemId, 'An identifier for the insert', :NMTOKEN
  attr(:IndexRange, 'A single or range of indexes. A range can be a comma separated set of individual elements as in "1,2,3,4", or as a inclusive range of values as in "1-10" or multiple ranges "1-4,6-10"') { pattern range }
  attr :Minimum, 'A minimum value', :float  
  attr :Maximum, 'A maximum value', :float
  attr :Nominal, 'A nominal value', :float
  attr :Grade, 'The material for a cutting item'
  attr :MaximumCount, 'A maximum count value', :integer
  attr :MeasurementCode, 'A application specific code'
  attr :Manufacturers, 'A comman delimited list of manufactures'
  attr :LocationRelation, 'A relationship', :NMTOKEN
  
  enum :DefinitionFormat, 'The format of the definition' do
    value :EXPRESS, 'The definition will be provided in EXPRESS format'
    value :XML, 'The definition will be provided in XML'
    value :TEXT, 'The definition will be provided in uninterpreted TEXT'
    value :UNDEFINED, 'The definition will be provided in an unspecified format'
  end
  
  enum :CutterStatusValue, 'The state of the tool. These can be combined to define the complete cutting tool state' do
    value :NEW, 'The tool is new'
    value :AVAILABLE, 'The cutting tool is available for use'
    value :UNAVAILABLE, 'The cutting tool is unavailable for use'
    value :ALLOCATED, 'The cutting tool is assigned to this proces'
    value :UNALLOCATED, 'The cutting tool is NOT assigned to this device'    
    value :MEASURED, 'The tool has been measured'
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
  
  enum :LocationsType, 'The type of tool location' do
    value :POT, 'A location in a tool magazine. updated'
    value :STATION, 'A location in a turret, tool bar, or tool rack. updated'
    value :CRIB, 'A location within a tool crib. updated'
    value :SPINDLE, 'A location associated with a spindle'
    value :TRANSFER_POT, 'A location for a tool awaiting transfer from a tool magazine to spindle or a turret'
    value :RETURN_POT, 'A location for a tool removed from a spindle or turret and awaiting return to a tool magazine'
    value :STAGING_POT, 'A location for a tool awaiting transfer to a tool magazine or turret from outside of the piece of equipment.'
    value :REMOVAL_POT, 'A location for a tool removed from a tool magazine or turret awaiting transfer to a location outside of the piece of equipment.'
    value :EXPIRED_POT, 'A location for a tool that is no longer useable and is awaiting removal from a tool magazine or turret.'
    value :END_EFFECTOR, 'A location associated with an end effector'
  end

  type :CuttingToolDefinition, 'The description of an asset, can be freeform text or elemenrts' do
    mixed
    member :format, 'The format of the data in the definition', 0..1, :DefinitionFormat do
      default = 'XML'
    end
    member :any, 'Any elements', 0..INF
  end 

  # Cutting tool definition
  type :CuttingTool, 'A cutting tool', :Asset do
    member :SerialNumber, 'The serial number of the asset', :SerialNumberAttr
    member :Manufacturers, 'The manufacturer of this asset', 0..1
    member :ToolId, 'The Identifier of the tool type', :CuttingToolId
    member :Description, 'The description of the cutting tool', 0..1, :AssetDescription
    
    at_least_one do 
      member :CuttingToolDefinition, 'DEPRECATED: Description of tool - now only in Archetype'
      member :CuttingToolLifeCycle, 'the tool lifecycle'
    end
  end
  
  # Archetype 
  type :CuttingToolArchetype, 'A Archetypical cutting tool', :Asset do
    member :toolId, 'The Identifier of the tool type', 0..1, :CuttingToolId
    member :Description, 'The description of the cutting tool', 0..1, :AssetDescription

    at_least_one do 
      member :CuttingToolDefinition, 'Description of tool'
      member :CuttingToolLifeCycle, 'the tool lifecycle', :CuttingToolLifeCycleArchetype
    end
  end
  
  type :CuttingToolLifeCycleArchetype, 'A archetypical cutting tool life cycle definition' do
    member :ReconditionCount, 'The number of times the cutter has been reconditioned', 0..1
    member :CuttingToolLife, 'The life of the cutting tool assembly', 0..3, :Life
    
    # Properties
    member :ProgramToolGroup, 'The number used to identify this tool in the program', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :ProcessSpindleSpeed, 'The tools constrained process target spindle speed', 0..1
    member :ProcessFeedRate, 'The tools constrained process target feed rate', 0..1
    member :ConnectionCodeMachineSide, 'CCMS: identifier for the cabability to connect any component of the cutting tool together, except assembly items, on the machine side', 0..1
    member :any, 'Any additional properties', 0..INF do
      self.notNamespace = "##targetNamespace"
      self.processContents = 'strict'
    end
    
    # Measurements
    member :Measurements, 'A set of measurements associated with the cutting tool', 0..1, :AssemblyMeasurements

    # Cutting Items
    member :CuttingItems, 'An optional list of edges for this assembly', 0..1
  end
  
  type :CuttingToolLifeCycle, 'A defintion of a cutting tool application and life cycle' do
    # Identification
    # Status
    member :CutterStatus, 'The state of the tool assembly - only for Instance (not archetype)', 1 
    member :ReconditionCount, 'The number of times the cutter has been reconditioned', 0..1
    member :ToolLife, 'The life of the cutting tool assembly', 0..3, :Life
    
    # Properties
    member :ProgramToolGroup, 'The number used to identify this tool in the program', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :Location, 'The pocket location', 0..1
    member :ProcessSpindleSpeed, 'The tools constrained process target spindle speed', 0..1
    member :ProcessFeedRate, 'The tools constrained process target feed rate', 0..1
    member :ConnectionCodeMachineSide, 'CCMS: identifier for the cabability to connect any component of the cutting tool together, except assembly items, on the machine side', 0..1
    member :any, 'Any additional properties', 0..INF do
      self.notNamespace = "##targetNamespace"
      self.processContents = 'strict'
    end
    # Measurements
    member :Measurements, 'A set of measurements associated with the cutting tool', 0..1, :AssemblyMeasurements

    # Cutting Items
    member :CuttingItems, 'An optional list of edges for this assembly', 0..1
  end
  
  type :CuttingToolArchetypeReference, 'A reference to the cutting tool archetype' do
    member :Source, 'A uri representing where to get the cutting tool architype', 0..1
    member :Value, 'The asset id of the archetype', :AssetId
  end
  
  type :CutterStatus, 'The set of applicatable status for this cutting tool' do
    element :Status, 'The status of the cutting tool', 1..INF, :CutterStatusValue
  end
  
  type :Location, 'The location of the tool in the tool changer (pot) or the station of the tool' do
    member :Type, 'The type of location', :LocationsType
    member :negativeOverlap, 'The additional locations occupied in at lower indexed values', 0..1, :Overlap
    member :positiveOverlap, 'The additional locations occupied in at higher indexed values', 0..1, :Overlap
    member :Turret, 'The turret associated with a tool', 0..1, :LocationRelation
    member :ToolMagazine, 'The tool magazine associated with a tool', 0..1, :LocationRelation
    member :ToolRack, 'The tool rack associated with a tool', 0..1, :LocationRelation
    member :ToolBar, 'The tool bar associated with a tool', 0..1, :LocationRelation
    member :AutomaticToolChanger, 'The automatic tool changer associated with a tool', 0..1, :LocationRelation
    member :Value, 'The location', :LocationValue
  end
  
  type :ReconditionCount, 'The number of times this tool has been reconditioned' do
    member :MaximumCount, 'The maximum number of times this tool can be reconditioned', 0..1
    member :Value, 'The number of times', :ReconditionCountValue
  end
  
  type :ProcessSpindleSpeed, 'The spindle speed properties of this tool' do
    member :Maximum, 'The maximum speed this tool may operate at', 0..1
    member :Minimum, 'The minimum speed this tool may operate at', 0..1
    member :Nominal, 'The nominal speed this tool may operate at', 0..1
    member :Value, 'The actual tool spindle speed', 0..1, :Speed
  end

  type :ProcessFeedRate, 'The feed rate properties of this tool in MILLIMETERS/SECOND' do
    member :Maximum, 'The maximum feed rate this tool may operate at', 0..1
    member :Minimum, 'The minimum feed rate this tool may operate at', 0..1
    member :Nominal, 'The nominal feed rate this tool may operate at', 0..1
    member :Value, 'The actual feed rate', 0..1, :Speed
  end
  
  # Define measurements for a cutting tool life cycle
  type :Measurement, 'An abstract type for edge measurements' do
    abstract
    member :SignificantDigits, "The number of significant digits", 0..1, :SignificantDigitsValue
    member :Units, 'The units for the measurement. This will be defined by MTConnect', 0..1
    member :NativeUnits, 'The native units for the measurement, if different from units', 0..1
    member :Code, 'The shop or application specific code for this measurement', 0..1, :MeasurementCode
    member :Maximum, 'The maximum tolerance value', 0..1, :MeasurementAttr
    member :Minimum, 'The minimum tolerance value', 0..1, :MeasurementAttr
    member :Nominal, 'The nominal value', 0..1, :MeasurementAttr
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
    ordered
    choice 1..INF do
      member :CommonMeasurement, 'Common measurements'
      member :AssemblyMeasurement, 'Assembly measurements'
    end
  end

  # Common
  type :ProtrudingLength, 'dimension from the yz-plane to the furthest point of the tool item or adaptive item measured in the -X direction', :CommonMeasurement
  type :Weight, 'WT: The weight measured in grams', :CommonMeasurement
  type :FunctionalLength, 'LF: The furthest distance from the gauge plane.', :CommonMeasurement
  
  # Cutting Tool - Assembly
  type :BodyDiameterMax, 'BDX: The largest diameter of the body of a tool item', :AssemblyMeasurement
  type :BodyLengthMax, 'LBX: The distance measured along the X axis from that point of the item closest to the workpiece, including the cutting item for a tool item but excluding a protuding locking mechanism for an adaptive item, to either the front of the flange on a flanged body or the beginning of the connection interface feature on the machine side for cylindrical or prismatic shanks', :AssemblyMeasurement
  type :CuttingDiameterMax, 'DC: The maximum diameter of a circle on which the defined point Pk of each of the master inserts is located on a tool item. The normal of the machined peripheral surface points towards the axis of the cutting tool.', :AssemblyMeasurement
  type :FlangeDiameterMax, 'The maxumum dimension between two parallel tangents on the outside edge of a flange', :AssemblyMeasurement
  type :DepthOfCutMax, 'APMX: The maximum engagement of the cutting edge or edges with the workpiece measured perpendicular to the feed motion.', :AssemblyMeasurement
  type :OverallToolLength, 'OAL: largest length dimension of the tool item including the master insert where applicable', :AssemblyMeasurement
  type :ShankDiameter, 'DMM: dimension of the diameter of a cylindrical portion of a tool item or an adaptive item that can participate in a connection', :AssemblyMeasurement
  type :ShankHeight, 'H: dimension of the height of a shank', :AssemblyMeasurement
  type :ShankLength, 'LS: dimension of the length of a shank', :AssemblyMeasurement
  type :UsableLengthMax, 'The maximum length of a cutting tool that can be used in a particular cutting operation including the non-cutting portions of the tool.', :AssemblyMeasurement
    
  type :Life, 'Abstract cutter life' do 
    member :Type, 'One of time, part count, or wear', 1, :ToolLifeType
    member :CountDirection, 'The count up or count down', 1, :ToolLifeDirection
    member :Warning, 'Tool life warning level', 0..1, :ToolLifeValue
    member :Limit, 'Maximum tool life', 0..1, :ToolLifeValue
    member :Initial, 'The life when the tool is new', 0..1, :ToolLifeValue
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
  type :CuttingReferencePoint, 'the theoretical sharp point of the cutting tool from which the major functional dimensions are taken', :CuttingItemMeasurement
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
  type :ToolOrientation, 'The orientation as expressed in degrees of the cutting item to the workpiece for this process.'
  type :DriveAngle, 'Angle between the driving mechanism locator on a tool item and the main cutting edge.'
  
  basic_type :Locus, 'The location of the cutting item - not yet restricted.'
  
      
  type :CuttingItems, 'A list of edge' do
    member :Count, 'The number of edges', :EdgeCount
    member :CuttingItem, 'An edge', 1..INF
  end
    
  type :CuttingItem, 'An edge into a tool assembly' do
    member :Indices, 'The unique identifier of this insert in this assembly', :IndexRange
    member :ItemId, 'The manufacturer identifier of this cutting item ', 0..1    
    member :Grade, 'The material used for the cutting item', 0..1
    member :Manufacturers, 'The manufacturer of this asset', 0..1
    
    member :Description, 'The description of the cutting item', 0..1, :AssetDescription
    member :CutterStatus, 'The status of an individual cutting item', 0..1, :CutterStatus
    member :Locus, 'The cutting item\'s location on the cutting tool', 0..1
    member :ItemLife, 'The life of an edge', 0..3, :Life
    member :ProgramToolGroup, 'The number used to identify this tool in the program', 0..1
    
    member :any, 'Any additional properties', 0..INF do
      self.notNamespace = "##targetNamespace"
      self.processContents = 'strict'
    end
    
    # Measurements
    member :Measurements, 'A set of measurements associated with the cutting tool', 0..1, :CuttingItemMeasurements
  end
end
