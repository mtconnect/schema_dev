# coding: utf-8

package :Process, 'Process' do
  attr :StepId, 'The identifier of the step', :NMTOKEN
  attr :RoutingId, 'The identifier of the step', :NMTOKEN
  attr :Precedence, 'The priority of a thing. A numberic indicator of the relative order of options.', :integer
  attr :ConstraintGroupId, 'A unique constraint identifier', :NMTOKEN
    
  enum :Discretionary, 'An optional item' do
    value :YES, 'The item is discretionary'
    value :NO, 'The item is required'
  end
  
  basic_type :StepDescription, 'The description of the step'
  basic_type :TargetTime, 'An amount of time in seconds', :float
  basic_type :ProgramSize, 'A size in bytes', :integer
  basic_type :Checksum, 'A checksum as a 32 bit unsigned value', :integer
  basic_type :CustomerName, 'A customer name'
  basic_type :VendorName, 'A vendor name'
  basic_type :CustomerAddress, 'A customer address'

  type :ProcessArchetype, 'Common information regarding a part kind', :AssetArchetype do
    member :Revision, 'An identifier for the current revision of the part.  A Revision ID can change over time. Historical Revision IDs are not a property of a Part.  (Historical Revision IDs may be stored by an application.)'
    
    member :TargetGroups, 'The target groups for this asset', 0..1
    member :Routings, 'The possible collections of process steps to make a part', 0..1
  end

  type :Process, 'Common information regarding a part kind', :AssetInstance do
    member :Revision, 'An identifier for the current revision of the part.  A Revision ID can change over time. Historical Revision IDs are not a property of a Part.  (Historical Revision IDs may be stored by an application.)'
    
    member :TargetGroups, 'The target groups for this asset', 0..1
    member :Routings, 'The possible collections of process steps to make a part', 0..1, :InstanceRoutings
  end

  type :Routings, 'A set of possible process steps' do
    member :Routing, 'The process steps for a particular routing', 1..INF
  end

  type :InstanceRoutings, 'The routings for an instance' do
    member :Routing, 'The process steps for a particular routing'
  end

  type :Routing, 'A collection of process steps' do
    member :Precedence, 'The priority of this routing', 0..1
    member :RoutingId, 'The identifier of this routing'
    member :ProcessStep, 'A process step', 1..INF
  end
  
  type :RoutingRef, 'A reference to a routing' do
    member :RoutingIdRef, 'The identifier of this routing'
    member :ProcessStepRef, 'A reference to a process step', 1..INF
  end
              
  type :ProcessConstraints, 'A set of constraints for various process data or parameters' do
    member :ProcessConstraintGroup, 'The process parameters of a type', 1..INF    
  end
  
  basic_type(:ConstraintGroupExt, 'An extension point for data item types') do
    pattern 'x:[A-Z_0-9]+'
  end
  
  type :ProcessDataRequests, 'A set request to have certain process data logged' do
    member :ComponentName, 'The component name', 0..1
    member :Component, 'The type of the component', :Name
    member :DataItemRequest, 'A process data request', 1..INF
  end
  
  type :DataItemRequest, 'A request to log data' do
    member :Type, 'The type of measurement', :DataItemEnum
    member :SubType, 'The sub type for the measurement', 0..1, :DataItemSubEnum
    member :Category, 'The category of the data item'
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
    member :Filter, 'A limit on the amount of data by specifying the minimal delta required.', 0..1, :DataItemFilter
  end
  
  type :ProcessConstraintGroup, 'The process data' do
    member :ConstraintGroupId, 'A constraint identifier'
    member :Sequence, 'The sequence number of the activity', 0..1, :SequenceNumber
    member :ComponentName, 'The name of a component if required', 0..1
    member :Component, 'The type of the component',  0..1, :Name
    member :DataItemConstraint, 'A set of data item constaints', 1..INF
  end
  
  enum :PartDataItemTypes, 'Extended Data Item Types', :DataItemEnum do
    value :SETUP_TIME, 'The time to setup the asset'
    value :TEARDOWN_TIME, 'The time to teardown the asset'
    value :EXECUTION_TIME, 'The target execution of the process'
  end
  
  type :DataItemConstraint, 'A abstract measurement' do
    member :Type, 'The type of measurement', :PartDataItemTypes
    member :SubType, 'The sub type for the measurement', 0..1, :DataItemSubEnum
    member :Units, 'The units of the measurement', 0..1
    member :Category, 'The category of the data item'
    member :Constraints, 'Limits on the set of possible values', :DataItemConstraints
  end
    
  type :ProcessStep, 'An individual step in the manufacturing process' do
    member :StepId, 'The identifier of this step'
    member(:Discretionary, 'This process step is discretionary', 0..1) { self.default = 'NO' }
    member :Description, 'The description of the step', 0..1, :StepDescription
    member :ProcessTargets, 'The locations or target devices', 0..1
    member :Prerequisites, 'A required set of steps for this step to begin', 0..1
    member :ControlPrograms, 'The names of the programs that are required for this step', 0..1
    member :ActivityGroups, 'A collection activites', 0..1
    member :ProcessConstraints, 'The process constraints', 0..1
    member :ProcessDataRequests, 'Requests to log data', 0..1
    member :AssetArchetypeRefs, 'A collection of assets used in this process step', 0..1
  end
  
  type :ProcessStepRef, 'A reference to a process step' do
    member :StepIdRef, 'The identifier of this step'
  end
  
  type :Prerequisites, 'A list of required steps for this step to begin' do
    member :Prerequisite, 'A reference to a previous step', 1..INF
  end
  
  type :Prerequisite, 'A reference to a previous process step. TODO: do we need to consider routing?' do
    choice do
      member :RoutingRef, 'A reference to the routing id. We may want to remove... if not given, detaults to the current routing'
      member :ProcessStepRef, 'A reference to the routing id. We may want to remove... if not given, detaults to the current routing'
    end
  end
  
  type :ActivityGroups, 'A collection of activities' do
    member :ActivityGroup, 'A process activity', 1..INF
  end
  
  attr :ActivityGroupName, 'Activity group name'
  type :ActivityGroup, 'A collection of activities' do
    member :Name, 'The activity group name', 0..1, :ActivityGroupName
    member :ActivityTargets, 'The target for this activity', 0..1, :ProcessTargetRef
    member :Activity, 'A process activity', 1..INF
  end
  
  attr :SequenceNumber, 'The  number indication the sequence of the operaton', :integer
  attr :ActivityId, 'The identifier of the activity associated with this cutting tool', :string
  attr :ActivityIdRef, 'The identifier of the activity associated with this cutting tool', :string
  
  type :Activities, 'A collection of activities' do
    member :Activity, 'A process activity', 1..INF
  end
  
    
  type :Activity, 'An activity within a Process Step' do
    member :Sequence, 'The sequence number of the activity', :SequenceNumber
    member(:Discretionary, 'This process step is discretionary', 0..1) { self.default = 'NO' }
    member :Precedence, 'The precedence of this activity if multiple activities have the same sequence', 0..1
    member :ActivityId, 'The activity id'
    member :Description, 'The description of the step', 0..1, :StepDescription
    member :ProcessConstraints, 'The process constraints', 0..1
    member :ProcessDataRequests, 'Requests to log data', 0..1
    member :AssetArchetypeRefs, 'Assets that are used in this activity', 0..1
    member :Activities, 'Sub activities', 0..1
  end
  
  type :ActivityRef, 'A reference to an activity' do
  end
      
  attr :Restrictions, 'An indicator of the restriction on this program'
  attr :ProgramName, 'A program name'
  basic_type :Signature, 'A GUID signature'
  
  type :ControlPrograms, 'A collection of program names' do
    member :ControlProgram, 'A program', 1..INF
  end
  
  type :ProcessTargets, 'A set of targets where this process can be run' do
    member :ProcessTarget, 'A set of target references with expected target times', 1..INF
  end
  
  attr :ProcessTargetId, 'A process target', :NMTOKEN
  attr :ProcessTargetIdRef, 'A process target', :NMTOKEN
  type :ProcessTarget, "A reference to a target id" do
    member :Precedence, 'The precedence of this activity if multiple activities have the same sequence', 0..1
    member :ProcessTargetId, 'The process target id'
    member :TargetRefs, "The target id or group references"
    member :ExecutionTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :SetupTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
    member :TeardownTime, 'The amount of time this part is supposed to take', 0..1, :TargetTime
  end
    
  
  type :TargetRefs, "The targets this activity is valid for" do
    choice do
      member :TargetRef, "The target id reference", 1..INF
      member :TargetGroupRef, "The target id reference", 1..INF
    end
  end
  
  type :ProcessTargetRef, 'A reference to a process target' do
    member :ProcessTargetIdRef, 'The process target id'
  end
  
  type :FileAssetRef, 'A reference to the asset file' do
    attribute :'xlink:href', 'Reference to the asset', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
    member :AssetId, 'Asset id of file'
  end
  
  type :ControlProgram, 'A control program' do
    member :Name, 'The program name', :ProgramName
    member :ProgramName, 'The name of the program on the machine'
    member :Revision, 'The revision of this program'
    member :Description, 'The description of the program', 0..1, :StepDescription
    member :FileAssetRef, 'A reference to the file asset', 0..1
    member :TargetRefs, "The target id or group references"
    member :Size, 'The size of the program in bytes', 0..1, :ProgramSize
    member :Timestamp, 'The time the program was last updated', 0..1, :Timestamp
    member :Restrictions, 'Indicator if this is controlled by some regulatory body', 0..1
    member :Signature, 'A secure signature', 0..1
  end
end
