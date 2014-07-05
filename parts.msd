package :Parts, 'Parts' do
  basic_type :CustomerId, 'A customer ID'
  basic_type :RawMaterial, 'The type of material used'
  attr :FamilyId, 'The family this part belongs to'
  attr :RevisionId, 'The revision of the part type'
  attr :StepID, 'The identifier of the step', :NMTOKEN
  basic_type :StepDescription, 'The description of the step'
  basic_type :TargetDevice, 'A device UUID'
  basic_type :ControlProgram, 'A control program'
  basic_type :TargetTime, 'An amount of time in seconds', :float
  
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
    
  type :PartInstance, 'A part or group of individual parts that are being from workpieces', :Asset do
    member :Description, 'The description of the part (freeform)', 0..1, :AssetDescription
  end
  
end