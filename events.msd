
package :Events, 'Event Package' do
  integer_value = '[+-]?\d+|UNAVAILABLE'
  line_pattern = "[A-Za-z0-9]+|UNAVAILABLE"  
  
  basic_type(:PartCountValue, 'The number of parts') { pattern integer_value }
  basic_type :BlockValue, 'Code block value'
  basic_type :CodeValue, 'Value of the program code'
  basic_type :ProgramValue, 'The program name'
  basic_type :ToolEventValue, 'A tool event'
  basic_type(:LineValue, 'The line number') { pattern line_pattern }
  basic_type :ToolIdValue, 'The tool identifier'
  basic_type :PartIdValue, 'The part identifier'
  basic_type :WorkholdingIdValue, 'The workholding identifier'
  basic_type :MessageValue, 'A message'
  basic_type(:AxesListValue, 'A space delimited list of values') { pattern 'UNAVAILABLE|[a-zA-Z][0-9]*( [a-zA-Z][0-9]*)*' }
    
  enum :DirectionValue, 'Rotation Direction' do
    value :CLOCKWISE, 'Rotary clockwise rotation'
    value :COUNTER_CLOCKWISE, 'Rotary counter clockwise rotation'
    value :POSITIVE, 'Linear motion in ascending values'
    value :NEGATIVE, 'Linear motion in decending values'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :PowerStateValue, 'A power status' do
    value :ON, 'The power is on'
    value :OFF, 'The power is off'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :ExecutionValue, 'The execution value' do
    value :READY, 'The cnc is idle and ready to do work'
    value :INTERRUPTED, 'The program has been paused'
    value :ACTIVE, 'The program is actively running'
    value :STOPPED, 'The program has been stopped'
    value :FEED_HOLD, 'The machine is in feed hold - spindle spinning/axis stopped'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :ControllerModeValue, 'The cnc mode value' do
    value :AUTOMATIC, 'The cnc is in automatic mode'
    value :MANUAL, 'The cnc is in manual mode'
    value :MANUAL_DATA_INPUT, 'The cnc is in manual data input mode (MDI)'
    value :SEMI_AUTOMATIC, 'The controller is operating in a single cycle, single block mode'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :DoorStateValue, 'The status of a door' do
    value :OPEN, 'The door is open'
    value :CLOSED, 'The door is closed'
    value :UNLATCHED, 'The door is not latched closed, but may not fully open'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :RotaryModeValue, 'The rotary functions' do
    value :SPINDLE, 'The rotary is spinning at a velocity'
    value :INDEX, 'The rotary axes is index to specific angles'
    value :CONTOUR, 'The rotary axes is both spinning and spinning'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :EmergencyStopValue, 'ESTOP values' do
    value :TRIGGERED, 'The device is in emergency stop'
    value :ARMED, 'ESTOP is ARMED'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :AxesCouplingValue, 'The method for axes coupling' do
    value :TANDEM, "The axes are physically associated"
    value :SYCHRONOUS, "The axes are operating in a peer synchronous manor"
    value :MASTER, "The axes in coupled axes are masters of this axis"
    value :SLAVE, "The axes in the coupled axes are slaves of this axes"
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :AvailabilityValue, 'Possible values for availability data item' do
    value :AVAILABLE, 'The component is available'
    value :UNAVAILABLE, 'The component is unavailable'
  end
  
  enum :ActuatorStateValue, 'The possible values for actuator state.' do
    value :ACTIVE, 'The actuator is active'
    value :INACTIVE, 'The actuator is inactive'
  end
  
  enum :PathModeValue, 'The values for path mode' do
    value :SYNCHRONOUS, 'The paths are working together in unison'
    value :MIRROR, 'The paths are making mirror images'
    value :INDEPENDENT, 'The paths are operating independently'
  end

  type :Event, 'An abstract event', :Result do
    abstract
  end

  type :Code, 'DEPRECATED: The program code', :Event do
    member :Value, 'Program code', :CodeValue
  end
  
  type :Block, 'The program code', :Event do
    member :Value, 'Program block', :BlockValue
  end

  type :Line, 'The program\'s line of execution', :Event do
    member :Value, 'Line number', :LineValue
  end

  type :PowerStatus, 'DEPRECATED: The components power status', :Event do
    member :Value, 'The on or off status of component', :PowerStateValue
  end

  type :PowerState, 'The components power state', :Event do
    member :Value, 'The on or off status of component', :PowerStateValue
  end
  
  type :PartCount, 'An event that indicates the number of parts', :Event do
    member :Value, 'The number of parts', :PartCountValue
  end

  type :Direction, 'The direction of rotation', :Event do
    member :Value, 'The direction of rotation', :DirectionValue
  end

  type :Program, 'The programs file name or identifier', :Event do
    member :Value, 'Program identifier', :ProgramValue
  end

  type :Execution, 'Program execution events', :Event do
    member :Value, 'The programs\'s execution state', :ExecutionValue
  end
  
  type :ControllerMode, 'CNC mode state', :Event do
    member :Value, 'The CNC mode state', :ControllerModeValue
  end
  
  type :ToolAssetId, 'The unique tool Identifier as referenced in part 4 - assets', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end
  
  type :ToolId, 'DEPRECATED in Rel. 1.2 See Tool_ASSET_ID.  The identifier of the tool currently in use for a given Path', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end
  
  type :ToolNumber, 'The identifier of a tool provided by the device controller.', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end  

  type :PartId, 'The current Tool Identifier', :Event do 
    member :Value, 'The tool identifier', :PartIdValue
  end
  
  type :DoorState, 'The status of the door', :Event do
    member :Value, 'The status of the door', :DoorStateValue
  end
  
  type :WorkholdingId, 'The current workholding Identifier', :Event do 
    member :Value, 'The workholding identifier', :WorkholdingIdValue
  end
  
  type :RotaryMode, 'The function of the rotary axis', :Event do
    member :Value, 'The rotary function', :RotaryModeValue
  end
  
  type :ActiveAxes, 'The list of axes in use', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end

  type :CoupledAxes, 'The list of associated axes', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end
  
  type :AxesCoupling, 'The way the axes are associated', :Event do
    member :Value, 'The association method', :AxesCouplingValue
  end
  
  type :Message, 'A generic message', :Event do
    member :NativeCode, 'The component specific Notifcation code', 0..1
    member :Value, 'A device message', :MessageValue
  end

  type :EmergencyStop, 'Emergency Stop status', :Event do
    member :Value, 'Emergency Stop value', :EmergencyStopValue
  end
  
  type :Availability, 'The availability of the component', :Event do
    member :Value, 'The availability', :AvailabilityValue
  end
  
  type :ActuatorState, 'The actuator state of the component', :Event do
    member :Value, 'The availability', :ActuatorStateValue
  end
  
  type :PathMode, 'The actuator state of the component', :Event do
    member :Value, 'The path mode', :PathModeValue
  end
  
  type :LinePowerState, 'The state of the line power', :PowerState
  type :ControlPowerState, 'The state of the line power', :PowerState
  
  # For assets  
  type :AssetChanged, 'An asset was just modified', :Event do
    member :AssetType, 'The type of asset that changed', :AssetAttrType
    member :Value, 'The asset identifier', :AssetId
  end
    
end
