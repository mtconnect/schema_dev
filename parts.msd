# coding: utf-8
package :Parts, 'Parts' do
  attr :CustomerId, 'A customer ID'
  attr :FamilyId, 'The family this part belongs to'
  attr :RevisionId, 'The revision of the part type'
  attr :DrawingId, 'The drawing identifier associated with this part'
  attr :StepId, 'The identifier of the step', :NMTOKEN
  attr :RoutingId, 'The identifier of the step', :NMTOKEN
  attr :Precedence, 'The priority of a thing. A numberic indicator of the relative order of options.', :integer
  attr :TargetId, 'The identifier of the target', :NMTOKEN
  
  
  enum :Discretionary, 'An optional item' do
    value :YES, 'The item is discretionary'
    value :NO, 'The item is required'
  end
  
  basic_type :StepDescription, 'The description of the step'
  basic_type :TargetTime, 'An amount of time in seconds', :float
  basic_type :ProgramSize, 'A size in bytes', :integer
  basic_type :Checksum, 'A checksum as a 32 bit unsigned value', :integer
  basic_type :CustomerName, 'A customer name'
  basic_type :CustomerLocation, 'A customer location'
    
  type :InspectionRef, 'The inspection reference' do
    abstract
    member :Href, 'A url to the inspection doc', 0..1, :Source
    member :Value, 'The id of the inspection doc', :InspectionId
  end  
    
  type :PartArchetype, 'Common information regarding a part kind', :Asset do
    member :Description, 'The description of the part (freeform)', 0..1, :AssetDescription
    member :FamilyId, 'A group this part belongs to', 0..1
    member :DrawingId, 'A drawing associated with this part', 0..1
    member :RevisionId, 'An identifier for the current revision of the part.  A Revision ID can change over time. Historical Revision IDs are not a property of a Part.  (Historical Revision IDs may be stored by an application.)'
    member :Characteristics, 'The characteristics of a part'
    member :Routings, 'The possible collections of process steps to make a part', 0..1
  end
  
  type :Routings, 'A set of possible process steps' do
    member :Routing, 'The process steps for a particular routing', 1..INF
  end
  
  type :Characteristics, 'Characteristics of a part archetype' do
    member :RawMaterial, 'Raw material'
    member :Customers, 'A customer identifier.  The combination of a Part ID and Customer ID can reference a customer Part Number', 0..1
  end
  
  attr :Standard, 'The hardness convention'
  attr :Scale, 'The hardness scale being used – default: Rockwell'
  
  type :Hardness, 'The hardness range' do
    member(:Scale, 'The hardness scale being used', 0..1) { self.default = 'ROCKWELL' }
    member :Minimum, 'The minimum hardness', 0..1
    member :Maximum, 'The maximum hardness', 0..1
    member :Nominal, 'The nominal hardness', 0..1
    value 'The actual hardness (only for instance)', :MeasurementValue
  end
  
  basic_type :MaterialTypeValue, 'The type of the material in a given material master'
  
  enum :MaterialSource, 'The description of the source of the material' do
    value :BAR_STOCK, 'The material is a bar stock'
    value :FORGING, 'The material is a forging'
    value :CASTING, 'The material is a casting'
    value :POWDER, 'The material is a powder'
    value :ROD, 'The material is a rod'
    value :FILIMENT, 'The material is a filiment'
    value :BAR_STOCK, 'The material is a bar stack'
  end

  type :MaterialType, 'The type of material' do
    member :Standard, 'The hardness standard or convention that is being used'
    member :Source, 'The source of the material', :MaterialSource, 0..1
    value 'The type of material in the given standard', :MaterialTypeValue
  end
  
  type :RawMaterial, 'Description of raw material' do
    member :Hardness, 'The hardness on the  scale of the raw material', 0..1
    member :MaterialType, 'The type of material'
  end
  
  type :Customers, 'A list of customer ids' do
    member :Customer, 'Some basic customer informaiton', 1..INF
  end
  
  type :Customer, 'Some basic customer information' do
    member :CustomerId, 'The customer identification'
    member :Name, 'The customer name', 0..1, :CustomerName
    member :Location, 'The customer location', 0..1, :CustomerLocation
    member :Description, 'Free form customer description', 0..1, :AssetDescription
  end
    
  type :Routing, 'A collection of process steps' do
    member :Precedence, 'The priority of this routing', 0..1
    member :RoutingId, 'The identifier of this routing', 0..1
    member :ProcessStep, 'A process step', 1..INF
  end
    
  
  type :ProcessStep, 'An individual step in the manufacturing process' do
    member :StepId, 'The identifier of this step'
    member(:Discretionary, 'This process step is discretionary', 0..1) { self.default = 'NO' }
    member :Description, 'The description of the step', 0..1, :StepDescription
    member :Targets, 'The locations or target devices'
    member :ControlPrograms, 'The names of the programs that are required for this step', 0..1
    member :TargetExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetSetupTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetTeardownTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :Activities, 'A collection activites', 0..1
    member :WorkHoldings, 'A collection of work holdings', 0..1
    member :InspectionArchetypeRef, 'A reference to an asset ID that has a inspection plan', 0..1, :InspectionRef
  end
  
  type :Targets, 'A list of target devices or locations' do
    member :Target, 'Where this process step will be done', 1..INF
  end
  
  enum :TargetTypeValue, 'The set of possible locations' do
    value :EXTERNAL, 'The step will be performed outside this facility'
    value :STOCK, 'The step will involve only manipulation of raw material'
    value :INVENTORY, 'The part or material will be placed in storage'
    value :QUEUE, 'The part or material will be placed in a queue'
    value :DEVICE, 'The target is a device'
  end
  
  basic_type :TargetValue, 'The target value. For a device it is the UUID, for a location it is a description or UUID'
  
  type :Target, 'The device or location something can be done at' do
    member :Precedence, 'The precedence of this activity if multiple activities have the same sequence', 0..1
    member :TargetId, 'The identifier of this target', 1
    member :Type, 'The type of the target', :TargetTypeValue
    member :Value, 'The location or device identifier or description', :TargetValue
  end  
  
  attr :Restrictions, 'An indicator of the restriction on this program'
  attr :ProgramName, 'A program name'
  basic_type :Signature, 'A GUID signature'
  
  type :ControlPrograms, 'A collection of program names' do
    member :ControlProgram, 'A program', 1..INF
  end
  
  type :ControlProgram, 'A control program' do
    member :Name, 'The program name', :ProgramName
    member :ProgramName, 'The name of the program on the machine'
    member :RevisionId, 'The revision of this program'
    member :TargetId, 'The associated target identifier. When DEVICE type', 0..1
    member :Description, 'The description of the program', 0..1, :StepDescription
    member :Size, 'The size of the program in bytes', 0..1, :ProgramSize
    member :Timestamp, 'The time the program was last updated', 0..1, :Timestamp
    member :Restrictions, 'Indicator if this is ITAR controlled', 0..1
    member :Signature, 'A secure signature', 0..1
  end
    
  type :Activities, 'A collection of activities' do
    member :Activity, 'A process activity', 1..INF
  end
  
  attr :SequenceNumber, 'The  number indication the sequence of the operaton', :integer
  attr :ActivityId, 'The identifier of the activity associated with this cutting tool', :string
  
  type :Activity, 'An activity within a Process Step' do
    member :Sequence, 'The sequence number of the tool', 0..1, :SequenceNumber
    member(:Discretionary, 'This process step is discretionary', 0..1) { self.default = 'NO' }
    member :Precedence, 'The precedence of this activity if multiple activities have the same sequence', 0..1
    member :ActivityId, 'The activity id', 0..1
    member :Targets, 'The locations or target devices'
    member :CuttingToolActivities, 'A Cutting tool tool asset id', 0..1
    member :WorkholdingRef, 'A workholding tool asset id', 0..1
    member :InspectionArchetypeRef, 'A reference to the inspection of the activity', 0..1, :InspectionRef
    member :ProcessSpindleSpeed, 'The tools constrained process target spindle speed', 0..1
    member :ProcessFeedRate, 'The tools constrained process target feed rate', 0..1
    member :TargetExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :Activities, 'Sub activities', 0..1
  end
  
  type :CuttingToolActivities, 'The tooling used for thi activity' do
    member :CuttingToolActivity, 'Cutting tool activity', 1..INF
  end
  
  type :CuttingToolActivity, 'A specification of how a cutting tool will be used in a process step' do
    member :CuttingToolAssetId, 'The refernce to the tool sequence number', 0..1
    member :ProgramToolGroup, 'The number used to identify this tool in the program', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
  end
  
  type :CuttingToolAssetId, 'A tool asset id' do
    member :Href, 'A reference to the tool asset as a direct URI', 0..1, :Source
    member :Value, 'The asset id', :AssetId
  end

  type :WorkHoldings, 'A collection of workholding' do
    member :WorkholdingRef, 'A workholding tool asset id', 1..INF
  end
  
  type :WorkholdingRef, 'A workholding asset id'do
    member :Value, 'The asset id', :AssetId
  end
    
  attr :WorkorderId, 'The identifier of this workorder'
  attr :SubCountLabel, 'The label of a sub count', :NMTOKEN
  basic_type :PartCount, 'The number of parts in this workorder', :integer
  basic_type :PurchaseOrderId, 'A purchase order identifier'
  basic_type :InspectionId, 'The asset id of the inspection doc'
    
  type :Part, 'A part or group of individual parts that are being from workpieces', :Asset do
    member :Description, 'The description of the part (freeform)', 0..1, :AssetDescription
    member :PartArchetypeRef, 'A reference to the archetype for this part', 0..1
    member :PartIdentifiers, 'The part identifiers'
    member :RevisionId, 'An identifier for the current revision of the part.'
    member :Workorder, 'A workorder for this part instance', 0..1
    member :ProcessEvents, 'The history of the process for this part instance', 0..1
  end
  
  type :PartArchetypeRef, 'A reference to the part archetype' do
    member :Href, 'The URL refernce of the archetype', 0..1, :Source
    member :Value, 'The architype id', :AssetId
  end
  
  type :PartIdentifiers, 'A collection of identifiers' do
    choice 1..INF do
      member :UniqueIdentifier, 'A unique serialized part identifier'
      member :GroupIdentifier, 'An identifier of a group of parts or a piece of raw material that will be transformed into multiple parts'
    end
  end
  
  basic_type :PartIdentifier, 'An identifier of a part', :NMTOKEN
  
  enum :TypeOfUinqueIdentifier, 'An identifier' do
    value :RAW_MATERIAL_ID, 'A raw material id'
    value :SERIAL_NUMBER, 'A serial number'
  end
  
  type :UniqueIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfUinqueIdentifier
    member :StepId, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end
  
  enum :TypeOfGroupIdentifier, 'An identifier' do
    value :HEAT_ID, 'A heat id'
    value :BATCH_ID, 'A batch id'
    value :LOT_ID, 'A lot id'
    value :RAW_MATERIAL_ID, 'A raw material id'
  end  

  type :GroupIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfGroupIdentifier
    member :StepId, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end
  
  
  type :Workorder, 'A workorder for the part' do
    member :WorkorderId, 'The workorder id'
    member :Customer, 'The customer for this part', 0..1
    member :TotalCount, 'The total number of parts in this work order', 0..1, :PartCount
    member :SubCounts, 'A collection of sub-counts', 0..1
    member :ExternalPurchaseOrderId, 'An identifier of the purchase order', 0..1, :PurchaseOrderId
  end
  
  type :SubCounts, 'A collection of sub count' do
    member :SubCount, 'A sub count', 1..INF
  end
  
  type :SubCount, 'A sub count' do
    member :Label, 'A subcount label', :SubCountLabel
    member :Value, 'A count for this group', :PartCount
  end
  
  basic_type :OperatorId, 'An operator Id'
  basic_type :PalletId, 'The pallet used in this process'
  basic_type :PartLocation, 'The location of the part if not on the machine'
  
  enum :ProcessEventState, 'The state of the process' do
    value :RAW, 'Raw material'
    value :IN_PROCESS, 'In process'
    value :RE_WORK, 'A re-work step'
    value :ON_HOLD, 'The process is on hold'
    value :SCRAP, 'The product of the process was scrapped'
    value :COMPLETE, 'The process was completed'
  end
  
  type :ProcessEvents, 'This history of this part' do
    member :ProcessEvent, 'The steps in the history', 1..INF
  end
  
  type :DeviceUuid, 'A device uuid' do
    member :Value, 'The uuid', :Uuid
  end
  
  basic_type :Yield, 'The yield of the process', :integer
  basic_type :AnnotationValue, 'An annotation', :string

  type :Annotations, 'A set of annotations' do
    member :Annotation, 'An annotation', 1..INF
  end

  type :Annotation, 'An annotation' do
    member :Timestamp, 'The time the annotation was recorded', 0..1, :Timestamp
    member :Value, 'The annotation', :AnnotationValue
  end

  type :Inspections, 'A set of inspections' do
    member :InspectionRef, 'An inspection', 1..INF
  end
  

  type :ProcessEvent, 'This history of this part' do
    member :Timestamp, 'The timestamp'
    member :DeviceUuid, 'The unique identifier of the device this process was performed on', 0..1
    member :Location, 'The location of the part if not on the machine', 0..1, :PartLocation
    member :State, 'The process state', :ProcessEventState
    member :RoutingId, 'The name of the routing'
    member :StepId, 'The step this history is associated with', 0..1
    member :OperatorId, 'The identifier of the operator', 0..1
    member :ControlPrograms, 'The control programs used in this event', 0..1
    member :PalletId, 'The pallet identifier', 0..1
    member :WorkholdingRef, 'The workholding identifier', 0..1
    member :RevisionId, 'The revision of the process used', 0..1
    member :Yield, 'The process yield', 0..1
    member :ActivityEvents, 'A set of activities associated with the process event', 0..1
    member :Inspections, 'A reference to the inspection results', 0..1
    member :Annotations, 'A set of annotations associated with the event', 0..1
  end
  
  type :ActivityEvents, 'Activity events' do
    member :ActivityEvent, 'An activity event', 1..INF
  end
  
  type :ActivityEvent, 'An event associated with a ProcessStep Operaiton' do
    member :Timestamp, 'The timestamp'
    member :SequenceNumber, 'The  number indication the sequence of the operaton', 0..1
    member :ActivityId, 'The activity id', 0..1
    member :InspectionRef, 'An inspection', 1..INF
    member :Characteristics, 'The characteristics of this part', 0..1
    member :Annotations, 'A set of annotations associated with the event', 0..1
  end
end
