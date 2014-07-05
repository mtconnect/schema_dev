package :Parts, 'Parts' do
  basic_type :CustomerId, 'A customer ID'
  basic_type :RawMaterial, 'The type of material used'
  attr :FamilyId, 'The family this part belongs to'
  attr :RevisionId, 'The revision of the part type'
  attr :StepId, 'The identifier of the step', :NMTOKEN
  
  basic_type :StepDescription, 'The description of the step'
  basic_type :TargetDevice, 'A device UUID'
  basic_type :TargetTime, 'An amount of time in seconds', :float
  basic_type :ProgramSize, 'A size in bytes', :integer
  basic_type :Checksum, 'A checksum as a 32 bit unsigned value', :integer
  
  attr(:ITARFlag, 'A flag') { pattern 'YES|NO' }
  attr :ProgramName, 'A program name'
    
  type :PartArchetype, 'Common information regarding a part kind', :Asset do
    member :Description, 'The description of the part (freeform)', 0..1, :AssetDescription
    member :FamilyId, 'A group this part belongs to', 0..1
    member :RevisionId, 'An identifier for the current revision of the part.  A Revision ID can change over time. Historical Revision IDs are not a property of a Part.  (Historical Revision IDs may be stored by an application.)'
    member :Characteristics, 'The charastics of a part'
    member :ProcessSteps, 'The process steps involved in making a part', 0..1
  end
  
  type :Characteristics, 'Characteristics of a part architype' do
    member :RawMaterial, 'Raw material'
    member :Customers, 'A customer identifier.  The combination of a Part ID and Customer ID can reference a customer Part Number', 0..1
  end  
  
  type :Customers, 'A list of customer ids' do
    member :CustomerId, 'A customer identifier.  The combination of a Part ID and Customer ID can reference a customer Part Number', 1..INF    
  end
  
  type :ProcessSteps, 'A collection of process steps' do
    member :ProcessStep, 'An operation', 1..INF
  end
  
  type :ProcessStep, 'An individual operation in the manufacturing process' do
    member :StepId, 'The identifier of this step'
    member :Description, 'The description of the step', 0..1, :StepDescription
    member :TargetDevice, 'The UUID of the device this step is intended for'
    member :ControlPrograms, 'The names of the programs that are required for this step', 0..1
    member :TargetExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetSetupime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TargetTeardownTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :Tools, 'A collection of tools', 0..1
    member :WorkHoldings, 'A collection of work holdings', 0..1
  end
  
  type :ControlPrograms, 'A collection of program names' do
    member :ControlProgram, 'A program', 1..INF
  end
  
  type :ControlProgram, 'A control program' do
    member :Name, 'The program name', :ProgramName
    member :NameOnMachine, 'The name of the program on the machine', :ProgramName
    member :RevisionId, 'The revision of this program'
    member :Description, 'The description of the program', 0..1, :StepDescription
    member :Size, 'The size of the program in bytes', 0..1, :ProgramSize
    member :Checksum, 'The checksum of the program', 0..1, :Checksum
    member :Timestamp, 'The time the program was last updated', 0..1, :Timestamp
    member :ITARControl, 'Indicator if this is ITAR controlled', 0..1, :ITARFlag  end
    
  type :Tools, 'A collection of tooling' do
    member :ToolAssetId, 'A Cutting tool tool asset id', 1..INF
  end
  
  type :ToolAssetId, 'A tool asset id'do
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
  basic_type :PurchaseOrder, 'A purchase order'
  basic_type :QualityId, 'The asset id of the quality doc'
    
  type :PartInstance, 'A part or group of individual parts that are being from workpieces', :Asset do
    member :Description, 'The description of the part (freeform)', 0..1, :AssetDescription
    member :PartArchitypeRef, 'A reference to the architype for this part', 0..1
    member :PartIdentifiers, 'The part identifiers'
    member :Workorder, 'A workorder for this part instance', 0..1
    member :ProcessHistory, 'The history of the process for this part instance', 0..1
    member :Quality, 'A reference to the quality information', 0..1
  end
  
  type :PartArchitypeRef, 'A reference to the part architype' do
    member :Href, 'The URL refernce of the architype', :Source
    member :Value, 'The architype id', :AssetId
  end
  
  type :PartIdentifiers, 'A collection of identifiers' do
    choice 1..INF do
      member :UniqueIdentifier, 'A unique serialized part identifier'
      member :GroupIdentifier, 'An identifier of a group of parts or a piece of raw material that will be transformed into multiple parts'
    end
  end
  
  basic_type :PartIdentifier, 'An identifier of a part', :NMTOKEN
  
  enum :TypeOfPartIdentifier, 'An identifier' do
    value :HEAT_ID, 'A heat id'
    value :BATCH_ID, 'A batch id'
    value :LOT_ID, 'A lot id'
    value :RAW_MATERIAL_ID, 'A raw material id'
    value :SERIAL_NUMBER, 'A serial number'
  end
  
  type :UniqueIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfPartIdentifier
    member :StepId, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end

  type :GroupIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfPartIdentifier
    member :StepId, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end
  
  type :Quality, 'The quality reference' do
    member :Href, 'A url to the quality doc', 0..1, :Source
    member :Value, 'The id of the quality doc', :QualityId
  end  
  
  type :Workorder, 'A workorder for the part' do
    member :WorkorderId, 'The workorder id'
    member :CustomerId, 'The customer for this part', 0..1
    member :TotalCount, 'The total number of parts in this work order', 0..1, :PartCount
    member :SubCounts, 'A collection of sub-counts', 0..1
    member :ExternalPurchaseOrder, 'An identifier of the purchase order', 0..1, :PurchaseOrder
  end
  
  type :SubCounts, 'A collection of sub count' do
    member :SubCount, 'A sub count', 1..INF
  end
  
  type :SubCount, 'A sub count' do
    member :Label, 'A subcount label', :SubCountLabel
    member :Count, 'A count for this group', :PartCount
  end
  
  basic_type :OperatorId, 'An operator Id'
  basic_type :PalletId, 'The pallet used in this process'
  basic_type :FixtureId, 'The fixture used'
  basic_type :PartLocation, 'The location of the part if not on the machine'
  
  enum :ProcessHistoryState, 'The state of the process' do
    value :RAW, 'Raw material'
    value :IN_PROCESS, 'In process'
    value :RE_WORK, 'A re-work step'
    value :ON_HOLD, 'The process is on hold'
    value :SCRAP, 'The product of the process was scrapped'
    value :COMPLETE, 'The process was completed'
  end
  
  type :ProcessHistory, 'This history of this part' do
    member :DeviceUuid, 'The unique identifier of the device this process was performed on', 0..1, :Uuid
    member :Location, 'The location of the part if not on the machine', 0..1, :PartLocation
    member :State, 'The process state', :ProcessHistoryState
    member :StepId, 'The step this history is associated with', 0..1
    member :OperatorId, 'The identifier of the operator', 0..1
    member :PalletId, 'The pallet identifier', 0..1
    member :FixtureId, 'The fixture identifier', 0..1
    member :RevisionId, 'The revision of the process used', 0..1
  end
end