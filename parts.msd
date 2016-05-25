# coding: utf-8

package :Parts, 'Parts' do
  attr :CustomerId, 'A customer ID'
  attr :PartVendor, 'The identifier of the vendor', :NMTOKEN
  attr :StepIdRef, 'The identifier of the step', :NMTOKEN
  attr :RoutingIdRef, 'The identifier of the step', :NMTOKEN

  type :Characteristics, 'Characteristics of a part archetype' do
    member :any, 'Any additional properties', 0..INF do
      self.notNamespace = "##targetNamespace"
      self.processContents = 'strict'
    end
  end  
  
  basic_type(:ScaleExt, 'An extension point for hardness scales') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  attr :Standard, 'The hardness convention'
  enum :Scale, 'The hardness scale being used – default: Rockwell' do
    extensible :ScaleExt
    
    value :ROCKWELL, 'The Rockwell Scale'
    value :BRINELL, 'The Brinell Scale'
    value :VICKERS, 'The Vickers Scale'
    value :KNOOP, 'The Knoop Scale'
    value :LEEB, 'The Leeb Scale'
    value :SCEROSCOPE, 'The Sceroscope Scale'
    value :SUPERFICIAL, 'The Suoerficial Scale'
  end
  
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
  end

  type :MaterialType, 'The type of material' do
    member :Standard, 'The hardness standard or convention that is being used'
    member :Source, 'The source of the material', :MaterialSource, 0..1
    value 'The type of material in the given standard', :MaterialTypeValue
  end
  
  type :Vendor, 'The vendor of the raw material' do
    member :Vendor, 'The vendor identifier', :PartVendor
    member :Name, 'The vendor name', :VendorName
    member :Description, 'The description of the vendor as freeform text', :AssetDescription, 0..1
  end
  
  # Does a process have a customer or does a part?
  type :Customers, 'A list of customer ids' do
    member :Customer, 'Some basic customer informaiton', 1..INF
  end
  
  type :Customer, 'Some basic customer information' do
    member :CustomerId, 'The customer identification'
    member :Name, 'The customer name', 0..1, :CustomerName
    member :Address, 'The customer location', 0..1, :CustomerAddress
    member :Description, 'Free form customer description', 0..1, :AssetDescription
  end
    
  # May want to move this to Part????
  type :RawMaterial, 'Description of raw material' do
    member :MaterialType, 'The type of material'
    member :Hardness, 'The hardness on the  scale of the raw material', 0..1
    member :Vendor, 'The vendor of the raw material', 0..1
  end

  type :PartArchitype, 'A part or group of individual parts that are being from workpieces', :AssetInstance do
    member :RawMaterial, 'Raw material'
    member :Customers, 'A customer identifier.  The combination of a Part ID and Customer ID can reference a customer Part Number', 0..1    
    member :Characteristics, 'The characteristics of a part', 0..1
  end

  attr :WorkorderId, 'The identifier of this workorder'
  attr :SubCountLabel, 'The label of a sub count', :NMTOKEN
  basic_type :TotalPartCount, 'The number of parts in this workorder', :integer
  basic_type :PurchaseOrderId, 'A purchase order identifier'
  basic_type :InspectionId, 'The asset id of the inspection doc'
        
  type :Part, 'A part or group of individual parts that are being from workpieces', :AssetInstance do
    member :PartIdentifiers, 'The part identifiers'
    member :Revision, 'An identifier for the current revision of the part.'
    member :Workorder, 'A workorder for this part instance', 0..1
    member :ProcessEvents, 'The history of the process for this part instance', 0..1
  end
    
  type :PartIdentifiers, 'A collection of identifiers' do
    choice 1..INF do
      member :UniqueIdentifier, 'A unique serialized part identifier'
      member :GroupIdentifier, 'An identifier of a group of parts or a piece of raw material that will be transformed into multiple parts'
    end
  end
  
  basic_type :PartIdentifier, 'An identifier of a part', :NMTOKEN
  
  enum :TypeOfUinqueIdentifier, 'An identifier' do
    value :RAW_MATERIAL, 'A raw material id'
    value :SERIAL_NUMBER, 'A serial number'
  end
  
  type :UniqueIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfUinqueIdentifier
    member :StepIdRef, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end
  
  enum :TypeOfGroupIdentifier, 'An identifier' do
    value :HEAT, 'A heat id'
    value :BATCH, 'A batch id'
    value :LOT, 'A lot id'
    value :RAW_MATERIAL, 'A raw material id'
  end  

  type :GroupIdentifier, 'A unique part' do
    member :Type, 'The serial number of an individual part', :TypeOfGroupIdentifier
    member :StepIdRef, 'The step this id is associated with', 0..1
    member :Value, 'The identifier', :PartIdentifier
    member :Timestamp, 'The timestamp'
  end
  
  
  type :Workorder, 'A workorder for the part' do
    member :WorkorderId, 'The workorder id'
    member :Customer, 'The customer for this part', 0..1
    member :TotalCount, 'The total number of parts in this work order', 0..1, :TotalPartCount
    member :SubCounts, 'A collection of sub-counts', 0..1
    member :ExternalPurchaseOrderId, 'An identifier of the purchase order', 0..1, :PurchaseOrderId
  end
  
  type :SubCounts, 'A collection of sub count' do
    member :SubCount, 'A sub count', 1..INF
  end
  
  type :SubCount, 'A sub count' do
    member :Label, 'A subcount label', :SubCountLabel
    member :Value, 'A count for this group', :TotalPartCount
  end
  
  basic_type :PartUser, 'An operator Id'
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
  
  type :ProcessData, 'Process data collected for a process step or an activity' do
    member :Timestamp, 'The time the annotation was recorded', 0..1, :Timestamp
    member :Samples, 'A collection of samples', 0..1
    member :Events, 'A collection of events', 0..1
    member :Condition, 'The representation of the devices condition', 0..1, :ConditionList
  end
  
  basic_type :BatchItem, 'The process index'

  type :ProcessEvent, 'This history of this part' do
    member :StepIdRef, 'A reference to the step id'
    member :RoutingIdRef, 'A reference to the routing id'
    member :Timestamp, 'The timestamp'
    member :TargetIdRef, 'The unique identifier of the device this process was performed on'
    member :State, 'The process state', :ProcessEventState
    member :Location, 'The location of the part if not on the machine', 0..1, :PartLocation
    member :BatchItem, 'The item of the batch', 0..1
    member :User, 'The identifier of the operator', 0..1, :PartUser
    member :ControlPrograms, 'The control programs used in this event', 0..1
    member :AssetRefs, 'The workholding identifier', 0..1
    member :Revision, 'The revision of the process used', 0..1
    member :ActivityEvents, 'A set of activities associated with the process event', 0..1
    member :ProcessData, 'A set of annotations associated with the event', 0..1
  end
  
  type :ActivityEvents, 'Activity events' do
    member :ActivityEvent, 'An activity event', 1..INF
  end
  
  type :ActivityEvent, 'An event associated with a ProcessStep Operaiton' do
    member :ActivityIdRef, 'The activity id', 0..1
    member :Timestamp, 'The timestamp'
    member :SequenceNumber, 'The  number indication the sequence of the operaton', 0..1
    member :State, 'The process state', :ProcessEventState
    member :AssetRefs, 'The workholding identifier', 0..1
    member :ProcessData, 'A set of annotations associated with the event', 0..1
  end
  
  # TODO: Access
  # Travel with the part:
  #  Collected once... analyzed.
  #  Events as they happen...
  #  Activity corelation – In the shop – nothing done.
  #  How do we associate with the r/t streaming data?
  #  Interoperability – can we use a standardized document structure?
  #  
  # Very little in the parts asset model that will directly apply to any machine tool
  # The information will flow down to the machine ... work with the model. 
  #
  # Interface to the machine... 
  #   Information Model to Define The Routing Planning
  #   Instance as part is being processed
  #   
  # Protocol
  #   Change protocol to be device specific
end
