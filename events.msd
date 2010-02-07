
package :Events, 'Event Package' do
  integer_value = '[+-]?\d+|UNAVAILABLE'
  
  basic_type(:PartCountValue, 'The number of parts') { pattern integer_value }
  basic_type :BlockValue, 'Code block value'
  basic_type :CodeValue, 'Value of the program code'
  basic_type :ProgramValue, 'The program name'
  basic_type :ToolEventValue, 'A tool event'
  basic_type(:LineValue, 'The line number') { pattern integer_value }
  basic_type :ToolIdValue, 'The tool identifier'
  basic_type :PartIdValue, 'The part identifier'
  basic_type :WorkholdingIdValue, 'The workholding identifier'
  basic_type(:AxesListValue, 'A space delimited list of values') { pattern '[a-zA-Z][0-9]*( [a-zA-Z][0-9]*)*' }
  
  enum :DirectionValue, 'Rotation Direction' do
    value :CLOCKWISE, 'Clockwise rotation'
    value :COUNTER_CLOCKWISE, 'Counter clockwise rotation'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :PowerStatusValue, 'A power status' do
    value :ON, 'The power is on'
    value :OFF, 'The power is off'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  enum :ExecutionValue, 'The execution value' do
    value :READY, 'The cnc is idle and ready to do work'
    value :INTERRUPTED, 'The program has been paused'
    value :ACTIVE, 'The program is actively running'
    value :STOPPED, 'The program has been stopped'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :ControllerModeValue, 'The cnc mode value' do
    value :AUTOMATIC, 'The cnc is in automatic mode'
    value :MANUAL, 'The cnc is in manual mode'
    value :MANUAL_DATA_INPUT, 'The cnc is in manual data input mode (MDI)'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :DoorStatusValue, 'The status of a door' do
    value :OPEN, 'The door is open'
    value :CLOSED, 'The door is closed'
    value :UNAVAILABLE, 'The value is indeterminate'
  end
  
  enum :RotaryFunctionValue, 'The rotary functions' do
    value :SPIN, 'The rotary is spinning at a velocity'
    value :INDEX, 'The rotary axes is index to specific angles'
    value :CONTOUR, 'The rotary axes is both spinning and spinning'
    value :UNAVAILABLE, 'The value is indeterminate'
  end

  type :Event, 'An abstract event', :Result do
    abstract
  end

  type :Code, 'The program code', :Event do
    member :Value, 'Program code', :CodeValue
  end
  
  type :Block, 'The program code', :Event do
    member :Value, 'Program block', :BlockValue
  end

  type :Line, 'The program\'s line of execution', :Event do
    member :Value, 'Line number', :LineValue
  end

  type :PowerStatus, 'The components power status', :Event do
    member :Value, 'The on or off status of component', :PowerStatusValue
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
  
  type :ToolId, 'The current Tool Identifier', :Event do 
    member :Value, 'The tool identifier', :ToolIdValue
  end
  
  type :PartId, 'The current Tool Identifier', :Event do 
    member :Value, 'The tool identifier', :PartIdValue
  end
  
  type :DoorStatus, 'The status of the door', :Event do
    member :Value, 'The status of the door', :DoorStatusValue
  end
  
  type :WorkholdingId, 'The current workholding Identifier', :Event do 
    member :Value, 'The workholding identifier', :WorkholdingIdValue
  end
  
  type :RotaryFunction, 'The function of the rotary axis', :Event do
    member :Value, 'The rotary function', :RotaryFunctionValue
  end
  
  type :ActiveAxes, 'The list of axes in use', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end

  type :SlaveAxes, 'The list of axes in use', :Event do
    member :Value, 'The list of axes', :AxesListValue
  end
end
