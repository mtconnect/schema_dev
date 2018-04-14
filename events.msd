# coding: utf-8

package :Events, 'Event Package' do
  integer_value = '[+-]?\d+|UNAVAILABLE'
  float = '[+-]?\d+(\.\d+)?([Ee][+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  line_pattern = "[A-Za-z0-9]*|UNAVAILABLE"
  
  basic_type(:EventCountValue, 'The number of parts') { pattern integer_value }
  basic_type :BlockValue, 'Code block value'
  basic_type :CodeValue, 'Value of the program code'
  basic_type :ProgramValue, 'The program name'
  basic_type :ToolEventValue, 'A tool event'
  basic_type(:LineValue, 'The line number') { pattern line_pattern }
  basic_type :ToolIdValue, 'The tool identifier'
  basic_type :AssetIdValue, 'The tool identifier'
  basic_type :PartIdValue, 'The part identifier'
  basic_type :MessageValue, 'A message'
  basic_type(:AxesListValue, 'A space delimited list of values') { pattern 'UNAVAILABLE|[a-zA-Z][0-9]*( [a-zA-Z][0-9]*)*' }
  basic_type(:OverrideValue, 'The value for a percent override') { pattern float_value }
  basic_type(:NumericEventValue, 'The value for a numeric floating point event') { pattern float_value }
    
  enum :BooleanValue, 'A yes/no value' do
    value :YES, 'yes'
    value :NO, 'no'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :Event, 'An abstract event', :Result do
    abstract
    attribute :ResetTriggered, 'An optional indicator that the event or sample was reset', 0..1, :DataItemResetValue
  end


  # ======================= Events start here =======================

  enum :ActuatorStateValue, 'The possible values for actuator state.' do
    value :ACTIVE, 'The actuator is active'
    value :INACTIVE, 'The actuator is inactive'
    value :UNAVAILABLE, 'The component is unavailable'
  end
  
  type :ActuatorState, 'The actuator state of the component', :Event do
    member :Value, 'The availability', :ActuatorStateValue
  end
  
  type :ActiveAxes, 'The list of axes in use', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end

  type :AssetChanged, 'An asset was just modified', :Event do
    member :AssetType, 'The type of asset that changed', :AssetAttrType
    member :Value, 'The asset identifier', :AssetId
  end

  type :AssetRemoved, 'An asset was just modified', :Event do
    member :AssetType, 'The type of asset that changed', :AssetAttrType
    member :Value, 'The asset identifier', :AssetId
  end

  enum :AvailabilityValue, 'Possible values for availability data item' do
    value :AVAILABLE, 'The component is available'
    value :UNAVAILABLE, 'The component is unavailable'
  end
  
  type :Availability, 'The availability of the component', :Event do
    member :Value, 'The availability', :AvailabilityValue
  end
  
  enum :AxesCouplingValue, 'The method for axes coupling' do
    value :TANDEM, "The axes are physically associated"
    value :SYCHRONOUS, "The axes are operating in a peer synchronous manor"
    value :MASTER, "The axes in coupled axes are masters of this axis"
    value :SLAVE, "The axes in the coupled axes are slaves of this axes"
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  type :AxesCoupling, 'The way the axes are associated', :Event do
    member :Value, 'The association method', :AxesCouplingValue
  end
  
  type :AxisFeedrateOverride, 'The override of the feedrate', :Event do
    member :Value, 'The override', :OverrideValue
  end

  type :AxisInterlock, 'Spindle lock status', :Event do
    member :Value, 'The status', :BooleanValue
  end
  
  enum :AxisStateValue, 'The values for the axis states' do
    value :HOME, 'The axis is in a home position'
    value :TRAVEL, 'The axis is not in a home position'
    value :STOPPED, 'The axis is stopped'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :AxisState, 'The home/travel state of the axis', :Event do
    member :Value, 'The status', :AxisStateValue
  end

  type :Block, 'The program code', :Event do
    member :Value, 'Program block', :BlockValue
  end

  type :BlockCount, 'The total count of the number of blocks of program code that have been executed since execution started', :Event do
    member :Value, 'An integer count value', :EventCountValue
  end

  enum :ChuckInterlockValue, 'The values for the chuck interlock state' do
      value :ACTIVE, 'The chuck cannot be operated'
      value :INACTIVE, 'The chuck can be operated'
      value :UNAVAILABLE, 'The value is indeterminate'
      
  end

  type :ChuckInterlock, 'Prevents the chuck from unclaming', :Event do
    member :Value, 'The status', :ChuckInterlockValue
  end
  
  enum :ChuckStateValue, 'The values of the clamp status' do
    value :OPEN, 'The clamp is open'
    value :CLOSED, 'The clamp is closed'
    value :UNLATCHED, 'The status is undefined'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :ChuckState, 'The chuck status', :Event do
    member :Value, 'The chuck mode', :ChuckStateValue
  end
    
  type :Code, 'DEPRECATED: The program code', :Event do
    member :Value, 'Program code', :CodeValue
  end
  
  enum :CompositionStateValue, 'The allowable values for composition states' do
    value :ACTIVE, 'Operating'
    value :INACTIVE, 'Not operating'
    value :RIGHT, 'Oriented right to the point of a positive confirmation'
    value :LEFT, 'Oriented left to the point of a positive confirmation'    
    value :TRANSITIONING,'in an intermediate position'
    value :OPEN, 'The element is open'
    value :CLOSED, 'The element is closed'
    value :UNLATCHED, 'The element is in a intermediate position, neither open or closed'
    value :ON, 'The element is powered or operational'
    value :OFF, 'The element is not powered or operational'
    value :UP, 'The element is in an upward position'
    value :DOWN, 'The element is in a downward position'
  end

  type :CompositionState, 'The state of a composition element', :Event do
    member :Value, 'The state', :CompositionStateValue
  end

  enum :ControllerModeValue, 'The cnc mode value' do
    value :AUTOMATIC, 'The cnc is in automatic mode'
    value :MANUAL, 'The cnc is in manual mode'
    value :MANUAL_DATA_INPUT, 'The cnc is in manual data input mode (MDI)'
    value :SEMI_AUTOMATIC, 'The controller is operating in a single cycle, single block mode'
    value :EDIT, 'The controller is currently editing a program in the foreground'
    value :UNAVAILABLE, 'The value is indeterminate'
  end  
 
  type :ControllerMode, 'CNC mode state', :Event do
    member :Value, 'The CNC mode state', :ControllerModeValue
  end

  enum :SwitchStateValue, 'The values for a switched value' do
    value :ON, 'The option is currently active'
    value :OFF, 'The option is inavtive'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  type :ControllerModeOverride, 'setting or operator selection that changes the behavior of a piece of equipment', :Event do
    member :Value, 'The override value', :SwitchStateValue
  end

  type :CoupledAxes, 'The list of associated axes', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end
  
  enum :DirectionValue, 'Rotation Direction' do
    value :CLOCKWISE, 'Rotary clockwise rotation'
    value :COUNTER_CLOCKWISE, 'Rotary counter clockwise rotation'
    value :POSITIVE, 'Linear motion in ascending values'
    value :NEGATIVE, 'Linear motion in decending values'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :Direction, 'The direction of rotation', :Event do
    member :Value, 'The direction of rotation', :DirectionValue
  end

  enum :DoorStateValue, 'The status of a door' do
    value :OPEN, 'The door is open'
    value :CLOSED, 'The door is closed'
    value :UNLATCHED, 'The door is not latched closed, but may not fully open'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  type :DoorState, 'The status of the door', :Event do
    member :Value, 'The status of the door', :DoorStateValue
  end

  type :EndOfBar, 'An end of bar status', :Event do
    member :Value, 'The status', :BooleanValue
  end
  
  enum :EmergencyStopValue, 'ESTOP values' do
    value :TRIGGERED, 'The device is in emergency stop'
    value :ARMED, 'ESTOP is ARMED'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :EmergencyStop, 'Emergency Stop status', :Event do
    member :Value, 'Emergency Stop value', :EmergencyStopValue
  end
  
  type :EquipmentMode, 'The equipment modes', :Event do
    member :Value, 'The functional state', :SwitchStateValue
  end

  enum :ExecutionValue, 'The execution value' do
    value :READY, 'The cnc is idle and ready toß do work'
    value :INTERRUPTED, 'The program has been paused'
    value :ACTIVE, 'The program is actively running'
    value :STOPPED, 'The program has been stopped'
    value :FEED_HOLD, 'The machine is in feed hold - spindle spinning/axis stopped'    
    value :PROGRAM_COMPLETED, 'The program has completed execution'
    value :PROGRAM_STOPPED, 'The program has stopped'
    value :OPTIONAL_STOP, 'The program has been intentionally optionally stopped using an M01 or similar code'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  type :Execution, 'Program execution events', :Event do
    member :Value, 'The programs\'s execution state', :ExecutionValue
  end
  
  enum :FunctionalModeValue, 'The valid functional modes' do
    value :UNAVAILABLE, 'The value is unavailable'
    value :PRODUCTION, 'The machine is producing parts'
    value :SETUP, 'A job is being setup on the device'
    value :TEARDOWN, 'A job is being torn down on the device'
    value :MAINTENANCE, 'The machine is being repaired or is undergoing scheduled maintenance'
    value :PROCESS_DEVELOPMENT, 'A machine is being used for part prove-out or developing a manufacturing process'
  end

  type :FunctionalMode, 'The current function the device is performing', :Event do
    member :Value, 'The functional mode of the device', :FunctionalModeValue
  end

  type :Hardness, 'The measured hardness of a material', :Event do
    member :Value, 'The floating point value of the hardness', :NumericEventValue
  end

  type :Line, 'DEPRECATED: The program\'s line of execution', :Event do
    member :Value, 'Line number', :LineValue
  end

  type :LineLabel, 'The identifier for a block of code in a program', :Event

  type :LineNumber, 'The reference to the position of a block within a control program', :Event do
    member :Value, 'Line number', :LineValue
  end

  type :Material, 'The identifier for the material', :Event

  type :Message, 'A generic message', :Event do
    member :NativeCode, 'The component specific Notifcation code', 0..1
    member :Value, 'A device message', :MessageValue
  end

  basic_type :OperatorIdValue, 'The operator identifier'
  
  type :OperatorId, 'The identifier of the operator of the device', :Event do
    member :Value, 'The operator identifier', :OperatorIdValue
  end
  
  basic_type :PalletIdValue, 'The pallet identifier'
  
  type :PalletId, 'The identifier of the pallet being used', :Event do
    member :Value, 'The pallet identifier', :PalletIdValue
  end

  type :PartCount, 'An event that indicates the number of parts', :Event do
    member :Value, 'The number of parts', :EventCountValue
  end

  type :PartId, 'The current Tool Identifier', :Event do 
    member :Value, 'The tool identifier', :PartIdValue
  end
  
  type :PathFeedrateOverride, 'The override of the feedrate', :Event do
    member :Value, 'The override', :OverrideValue
  end

  enum :PathModeValue, 'The values for path mode' do
    value :SYNCHRONOUS, 'The paths are working together in unison'
    value :MIRROR, 'The paths are making mirror images'
    value :INDEPENDENT, 'The paths are operating independently'
    value :MASTER, 'The path provides the reference motion for a SYNCHRONOUS or MIRROR type'
  end
  
  type :PathMode, 'The actuator state of the component', :Event do
    member :Value, 'The path mode', :PathModeValue
  end
  
  enum :PowerStateValue, 'A power status' do
    value :ON, 'The power is on'
    value :OFF, 'The power is off'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :PowerState, 'The components power state', :Event do
    member :Value, 'The on or off status of component', :PowerStateValue
  end
  
  type :PowerStatus, 'DEPRECATED: The components power status', :Event do
    member :Value, 'The on or off status of component', :PowerStateValue
  end

  type :Program, 'The programs file name or identifier', :Event do
    member :Value, 'Program identifier', :ProgramValue
  end

  enum :ProgramEditValue, 'The values for the program edit values' do
      value :ACTIVE, 'A program is currently being edited'
      value :READY, 'The controller is vapable of editing a program, but is not currently editing a program'
      value :NOT_READY, 'The controller is in a state where it cannot edit a program'
      value :UNAVAILABLE, 'The value is unavailable'
  end
  
  type :ProgramEdit, 'The program edit state', :Event do
      member :Value, 'The program edit state', :ProgramEditValue
  end
  
  type :ProgramEditName, 'The name of the program being edited', :Event do
      member :Value, 'The name of the program being edited', :ProgramValue
  end

  basic_type :ProgramCommentValue, 'A comment'
  
  type :ProgramComment, 'A comment in the control program', :Event do
    member :Value, 'The comment', :ProgramCommentValue
  end

  basic_type :ProgramHeaderValue, 'A header'
  
  type :ProgramHeader, 'A header in the control program', :Event do
    member :Value, 'The header', :ProgramHeaderValue
  end

  enum :RotaryModeValue, 'The rotary functions' do
    value :SPINDLE, 'The rotary is spinning at a velocity'
    value :INDEX, 'The rotary axes is index to specific angles'
    value :CONTOUR, 'The rotary axes is both spinning and spinning'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :RotaryMode, 'The function of the rotary axis', :Event do
    member :Value, 'The rotary function', :RotaryModeValue
  end
  
  type :RotaryVelocityOverride, 'The override of the spindle speed (rotary velocity)', :Event do
    member :Value, 'The override', :OverrideValue
  end
  
  type :SerialNumber, 'The serial number associated with a Component, Asset, or Device', :Event

  enum :SpindleInterlockValue, 'The values for spindle interlock' do
    value :ACTIVE, 'Power has been removed and the spindle cannot be operated'
    value :INACTIVE, 'Spindle has not been deactivated'
  end
  
  type :SpindleInterlock, 'The interlock state of a spindle', :Event do
    member :Value, 'The state of the interlock', :SpindleInterlockValue
  end
       
  type :ToolId, 'DEPRECATED: The unique tool Identifier as referenced in part 4 - assets', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end
  
  type :ToolNumber, 'The unique tool number as referenced in part 4 - assets', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end

  type :ToolAssetId, 'The unique tool Identifier as referenced in part 4 - assets', :Event do 
    member :Value, 'The tool identifier', :AssetIdValue
  end

  type :ToolOffset, 'A refernce to the tool offset tables', :Event

  type :User, 'The identifier of the person responsible for operating the piece of equipment', :Event

  type :Wire, 'The identifier for the type of wire used as the cutting mechanism in EDM', :Event

  type :WorkholdingId, 'The identifier for the workholding or clamp in use', :Event

  type :WorkOffset, 'A reference to the work offset tables', :Event

  # ---------------------------------------------------

  # Create discrete events for non-state events
  %w{PartCount ToolId ToolNumber ToolAssetId PalletId Message Block}.map do |s| 
    self.schema.type(s.to_sym) 
  end.each do |type|
    self.type "#{type.name}Discrete".to_sym, "Discrete of #{type.annotation}", type.name
  end
end
