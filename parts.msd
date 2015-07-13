# coding: utf-8
package :Parts, 'Parts' do
  attr :CustomerId, 'A customer ID'
  attr :FamilyId, 'The family this part belongs to'
  attr :RevisionId, 'The revision of the part type'
  attr :StepId, 'The identifier of the step', :NMTOKEN
  
  basic_type :StepDescription, 'The description of the step'
  basic_type :TargetDevice, 'A device UUID'
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
    member :RevisionId, 'An identifier for the current revision of the part.  A Revision ID can change over time. Historical Revision IDs are not a property of a Part.  (Historical Revision IDs may be stored by an application.)'
    member :Characteristics, 'The characteristics of a part'
    member :ProcessSteps, 'The process steps', 0..1
    member :AlternativeProcessSteps, 'A set of alternative flows', 0..1
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

  type :MaterialType, 'The type of material' do
    member :Standard, 'The hardness standard or convention that is being used'
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
  
  type :AlternativeProcessSteps, 'Alternative process flows' do
    member :ProcessSteps, 'A list of process steps', 1..INF
  end
  
  type :ProcessSteps, 'A collection of process steps' do
    member :Name, 'An optional name', 0..1
    member :ProcessStep, 'An operation', 1..INF
  end
    
  enum :TargetLocationTypeValue, 'The set of possible locations' do
    value :EXTERNAL, 'The step will be performed outside this facility'
    value :STOCK, 'The step will involve only manipulation of raw material'
    value :INVENTORY, 'The part or material will be placed in storage'
  end
  
  type :TargetLocation, 'The non-device location of a step' do
    member :Type, 'The type of the location', :TargetLocationTypeValue
  end
  
  type :ProcessStep, 'An individual operation in the manufacturing process' do
    member :StepId, 'The identifier of this step'
    member :Description, 'The description of the step', 0..1, :StepDescription
    member :Targets, 'The locations or target devices'
    member :ControlPrograms, 'The names of the programs that are required for this step', 0..1
    member :TargetExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetSetupTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetTeardownTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :CuttingTools, 'A collection of tools', 0..1
    member :WorkHoldings, 'A collection of work holdings', 0..1
    member :InspectionArchetypeRef, 'A reference to an asset ID that has a inspection plan', 0..1, :InspectionRef
  end
  
  type :Targets, 'A list of target devices or locations' do
    choice do
      member :TargetDevice, 'The UUID of the device this step is intended for', 1..INF
      member :TargetLocation, 'The Location the step will be performed if not on a device', 1..INF
    end      
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
    member :Description, 'The description of the program', 0..1, :StepDescription
    member :Size, 'The size of the program in bytes', 0..1, :ProgramSize
    member :Checksum, 'The checksum of the program', 0..1, :Checksum
    member :Timestamp, 'The time the program was last updated', 0..1, :Timestamp
    member :Restrictions, 'Indicator if this is ITAR controlled', 0..1
    member :Signature, 'A secure signature', 0..1
  end
    
  type :CuttingTools, 'A collection of tooling' do
    member :CuttingToolSetup, 'A Cutting tool tool asset id', 1..INF
  end
  
  attr :SequenceNumber, 'The  number indication the sequence of the operaton', :integer
  attr :OperationId, 'The identifier of the operation associated with this cutting tool', :string
  
  type :CuttingToolSetup, 'A specification of how a cutting tool will be used in a process step' do
    member :Sequence, 'The sequence number of the tool', 0..1, :SequenceNumber
    member :OperationId, 'The operation id', 0..1
    member :CuttingToolAssetId, 'The refernce to the tool sequence number', 0..1
    member :ProgramToolGroup, 'The number used to identify this tool in the program', 0..1
    member :ProgramToolNumber, 'The number used to identify this tool in the program', 0..1
    member :ProcessSpindleSpeed, 'The tools constrained process target spindle speed', 0..1
    member :ProcessFeedRate, 'The tools constrained process target feed rate', 0..1
    member :TargetExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
  end
  
  type :CuttingToolAssetId, 'A tool asset id' do
    member :Href, 'A reference to the tool asset as a direct URI', 0..1, :Source
    member :Value, 'The asset id', :AssetId
  end

  type :WorkHoldings, 'A collection of workholding' do
    member :WorkholdingId, 'A workholding tool asset id', 1..INF
  end
  
  type :WorkholdingId, 'A workholding asset id'do
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
  basic_type :FixtureId, 'The fixture used'
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
    member :StepId, 'The step this history is associated with', 0..1
    member :OperatorId, 'The identifier of the operator', 0..1
    member :ControlPrograms, 'The control programs used in this event', 0..1
    member :WorkholdingId, 'The workholding identifier', 0..1
    member :RevisionId, 'The revision of the process used', 0..1
    member :Yield, 'The process yield', 0..1
    member :Inspections, 'A reference to the inspection results', 0..1
    member :Annotations, 'A set of annotations associated with the event', 0..1
  end
end
