

package :common, 'Common attributes and elements for all schemas' do
  attr :Sender, 'The sender of the message'
  attr :CreationTime, 'The date and time the document was created', :dateTime
  attr :Sequence, 'A sequence number', :integer
  attr :TestIndicator, 'A debugging flag for testing.', :boolean
  attr :InstanceId, 'The instance number of the agent, used for fault tolerance'
  attr :BufferSize, 'The size of the agents buffer', :integer

  attr :Version, 'A version number', :NMTOKEN
  attr :Name, 'A short name for any element'
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumber, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ID, 'An identifier', :ID

  basic_type :DescriptionText, 'A description'
    
  enum :DataItemEnum, 'The types of measurements available' do
    value :ACCELERATION, 'The accelleration of the component'
    value :ACTIVE_AXES, 'The list of axes currently in use in this path'
    value :ALARM, 'An alarm measurement.'
    value :AMPERAGE, 'The electrical current'
    value :ANGLE, 'The position as given in degrees'
    value :ANGULAR_ACCELERATION, 'The accelleration of the component'
    value :ANGULAR_VELOCITY, 'The velocity of the component'
    value :BLOCK, 'The current executing block'
    value :CODE, 'The current executing code'
    value :DISPLACEMENT, 'The displacement as measured from zero to peak'
    value :DIRECTION, 'The direction of rotation'
    value :DOOR_STATE, 'The open/closed state of the door'
    value :EXECUTION, 'The programs execution state'
    value :FREQUENCY, 'The frequency as measure in cycles per second'
    value :PART_ID, 'The identifier of the part loaded'
    value :PATH_FEEDRATE, 'The feedrate for the path'
    value :PATH_POSITION, 'The three space position X, Y, Z'
    value :AXIS_FEEDRATE, 'The feedrate for the axis'
    value :LINE, 'The line of the program being executed'
    value :CONTROLLER_MODE, 'The CNC\'s mode'
    value :LOAD, 'The load on the component'
    value :OTHER, 'An extension point'
    value :POSITION, 'The position as given in mm'
    value :POWER_STATUS, 'The power status of the component'
    value :POWER_STATE, 'The power state of the component'
    value :PRESSURE, 'The current pressure'
    value :PROGRAM, 'The name of the program being run'
    value :ROTARY_MODE, 'The function of the rotary axis'
    value :SPINDLE_SPEED, 'The velocity of the spindle'
    value :STATUS, 'The status indicator'
    value :TEMPERATURE, 'The temperature of the component'
    value :TORQUE, 'The torque - force times distance'
    value :TOOL_ID, 'The identifier of the tool in use'
    value :VELOCITY, 'The velocity of the component'
    value :VIBRATION, 'The status indicator'
    value :VOLTAGE, 'The voltage'
    value :WATTS, 'The wattage'
    value :WORKHOLDING_ID, 'The workholding identifier'
    
    
    # Condition types
    value :COMMUNICATIONS, 'The communications system'
    value :LOGIC_PROGRAM, 'The logic program'
    value :MOTION_PROGRAM, 'The motion program'
    value :HARDWARE, 'The computer hardware has failed'
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    value :ACTUAL, 'The actual position with absolute coordinates'
    value :COMMANDED, 'The expected value from the controller'
    value :MAXIMUM, 'The maximum value for this measurement'
    value :MINIMUM, 'The minimum value for this measurement'
    value :OTHER, 'An extension point'
    value :OVERRIDE, 'The override for the measurement'
    value :TARGET, 'The target position'
    value :GOOD, 'The good count'
    value :BAD, 'The bad count'
    value :ALL, 'Inclusive of all items'
  end
end
