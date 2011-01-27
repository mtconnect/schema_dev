

package :common, 'Common attributes and elements for all schemas' do
  attr :Sender, 'The sender of the message'
  attr :CreationTime, 'The date and time the document was created', :dateTime
  attr :Sequence, 'A sequence number', :integer
  attr :TestIndicator, 'A debugging flag for testing.', :boolean
  attr :InstanceId, 'The instance number of the agent, used for fault tolerance'
  attr :BufferSize, 'The size of the agents buffer', :integer
  
  attr :Timestamp, 'The time the sample was reported', :dateTime
  attr :OccurrenceTime, 'The time a sample occurred', :dateTime
  attr :Version, 'A version number', :NMTOKEN
  attr :Name, 'A short name for any element'
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumber, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ID, 'An identifier', :ID
  
  attr :AssetId, 'The unique id of the asset'

  basic_type :DescriptionText, 'A description'
  basic_type(:DataItemExt, 'An extension point for data item types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  basic_type(:DataItemStatsExt, 'An extension point for data item statistics types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  
  enum :DataItemEnum, 'The types of measurements available' do
    extensible :DataItemExt
    
    value :ACCELERATION, 'The accelleration of the component'
    value :ACTIVE_AXES, 'The list of axes currently in use in this path'
    value :ALARM, 'DEPRECATED: An alarm'
    value :AMPERAGE, 'The electrical current'
    value :ANGLE, 'The position as given in degrees'
    value :ANGULAR_ACCELERATION, 'The accelleration of the component'
    value :ANGULAR_VELOCITY, 'The velocity of the component'
    value :ASSET_ADDED, 'A new asset has been added'
    value :ASSET_CHANGED, 'A new asset has been added'
    value :AVAILABILITY, 'The components availability'
    value :BLOCK, 'The current executing block'
    value :CODE, 'The current executing code'
    value :DISPLACEMENT, 'The displacement as measured from zero to peak'
    value :DIRECTION, 'The direction of rotation'
    value :DOOR_STATE, 'The open/closed state of the door'
    value :EMERGENCY_STOP, 'The state of the ESTOP button'
    value :EXECUTION, 'The programs execution state'
    value :FREQUENCY, 'The frequency as measure in cycles per second'
    value :PART_COUNT, 'A count of the parts'
    value :PART_ID, 'The identifier of the part loaded'
    value :PATH_FEEDRATE, 'The feedrate for the path'
    value :PATH_POSITION, 'The three space position X, Y, Z'
    value :AXIS_FEEDRATE, 'The feedrate for the axis'
    value :LINE, 'The line of the program being executed'
    value :CONTROLLER_MODE, 'The CNC\'s mode'
    value :LOAD, 'The load on the component'
    value :MESSAGE, 'A uninterpreted message'
    value :POSITION, 'The position as given in mm'
    value :POWER_STATUS, 'DEPRECATED: The power status of the component'
    value :POWER_STATE, 'The power state of the component'
    value :PRESSURE, 'The current pressure'
    value :RESET, 'The statistical reset event'
    value :PROGRAM, 'The name of the program being run'
    value :ROTARY_MODE, 'The function of the rotary axis'
    value :COUPLED_AXES, 'The axes to which this axis is associated'
    value :AXIS_COUPLING, 'The method the axes are coupled together'
    value :SPINDLE_SPEED, 'DEPRECATED: The velocity of the spindle'
    value :TEMPERATURE, 'The temperature of the component'
    value :TORQUE, 'The torque - force times distance'
    value :TOOL_ID, 'The identifier of the tool in use'
    value :VELOCITY, 'The velocity of the component'
    value :VIBRATION, 'The status indicator'
    value :VOLTAGE, 'The voltage'
    value :WATTAGE, 'The wattage'
    value :WORKHOLDING_ID, 'The workholding identifier'
    
    # Types for 1.2
    value :DISPLACEMENT, 'The linear displacement in mm'
    value :TILT, 'micrometer/meter (alignment errors of axes or spindle errors)'
    value :ELAPSED_TIME, 'The accumulated time for a category or classification'
    value :DURATION, 'The duration of an event or happening'
    value :POWER_FACTOR, 'The power factor'
    value :STRAIN, 'Inches / Inch - dimensional change - measured under pressure or tension. micro change in length'
    value :FLOW, 'The number of liters in a second'
    value :SOUND_PRESSURE, 'sound pressure level'
    value :RESISTANCE, 'Electrical resistance'
    value :CONDUCTIVITY, 'CONDUCTIVITY'
    value :VISCOSITY, 'viscosity'
    value :CONCENTRATION, 'Percentage of one component in all components. Subtypes: WEIGHT, VOLUME, MOLE'
    value :ROTATIONAL_VELOCITY, 'The rotational velocity in revolutions per minute'
    
    # Condition types
    value :COMMUNICATIONS, 'The communications system'
    value :LOGIC_PROGRAM, 'The logic program'
    value :MOTION_PROGRAM, 'The motion program'
    value :HARDWARE, 'The computer hardware has failed'
    value :SYSTEM, 'A system level condition'
    value :LEVEL, 'The level of a resource'
    value :ACTUATOR, 'An actuator related condition'
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    extensible :DataItemExt
    
    value :ACTUAL, 'The actual position with absolute coordinates'
    value :COMMANDED, 'The expected value from the controller'
    value :MAXIMUM, 'The maximum value for this measurement'
    value :MINIMUM, 'The minimum value for this measurement'
    value :OTHER, 'An extension point'
    value :OVERRIDE, 'The override for the measurement'
    value :PROBE, 'The position given by a probe'
    value :TARGET, 'The target position'
    value :GOOD, 'The good count'
    value :BAD, 'The bad count'
    value :ALL, 'Inclusive of all items'
    value :LINE, 'The high voltage subtype for power state'
    value :CONTROL, 'The low voltage subtype for power state'
    
    # For 1.2
    value :WEIGHT, 'Concentration in weight'
    value :VOLUME, 'Concentration in volume'
    value :MOLE, 'Concentration in mole'
  end
  
  enum :DataItemStatistics, 'Statistical operations on data' do
    extensible :DataItemStatsExt
    
    value :MINIMUM, 'The minimum value'
    value :MAXIMUM, 'The maximum value'
    value :AVERAGE, 'The average'
    value :STANDARD_DEVIATION, 'The standard deviation'
    value :ROOT_MEAN_SQUARE, 'The root mean square'
    value :MEAN, 'The mean average'
    value :MODE, 'The mode of the sample'
  end
end
