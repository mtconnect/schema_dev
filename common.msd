

package :common, 'Common attributes and elements for all schemas' do
  attr :Sender, 'The sender of the message'
  attr :CreationTime, 'The date and time the document was created', :dateTime
  attr(:Sequence, 'A sequence number', :integer) do
    facet 'minIncl=1;maxExcl=18446744073709551615'
  end
  attr :TestIndicator, 'A debugging flag for testing.', :boolean
  attr(:InstanceId, 'The instance number of the agent, used for fault tolerance', :integer) do
    facet 'minIncl=1;maxExcl=18446744073709551615'
  end
  attr(:BufferSize, 'The size of the agents buffer', :integer) do 
    facet 'minIncl=1;maxExcl=4294967295'
  end
  
  attr :Timestamp, 'The time the sample was reported', :dateTime
  attr :OccurrenceTime, 'The time a sample occurred', :dateTime
  attr :Version, 'A version number', :NMTOKEN
  attr :Name, 'A short name for any element'
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumber, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ComponentId, 'The id of the component (maps to the id from probe)', :ID
  attr :ID, 'An identifier', :ID
  attr :SignificantDigitsValue, 'The number significant digits', :integer
  
  attr :AssetId, 'The unique id of the asset'
  attr :AssetAttrType, 'An asset type'
  attr(:AssetBufferSize, 'The maximum number of assets', :integer) do
    facet 'minIncl=1;maxExcl=4294967295'
  end
  attr(:AssetCountAttr, 'The number of assets', :integer) do
    facet 'minIncl=0;maxExcl=4294967295'    
  end

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
    value :AVAILABILITY, 'The components availability'
    value :AXIS_FEEDRATE, 'The feedrate for the axis'
    value :BLOCK, 'The current executing block'
    value :CODE, 'The current executing code'
    value :DIRECTION, 'The direction of rotation or linear motion'
    value :DOOR_STATE, 'The open/closed state of the door'
    value :EMERGENCY_STOP, 'The state of the ESTOP button'
    value :EXECUTION, 'The programs execution state'
    value :FREQUENCY, 'The frequency as measure in cycles per second'
    value :PART_COUNT, 'A count of the parts'
    value :PART_ID, 'The identifier of the part loaded'
    value :PATH_FEEDRATE, 'The feedrate for the path'
    value :PATH_POSITION, 'The three space position X, Y, Z'
    value :PATH_MODE, 'The mode of the path'
    value :LINE, 'The line of the program being executed'
    value :CONTROLLER_MODE, 'The CNC\'s mode'
    value :LOAD, 'The load on the component as a percentage of rated'
    value :MESSAGE, 'A uninterpreted message'
    value :POSITION, 'The position as given in mm'
    value :POWER_STATUS, 'DEPRECATED: The power status of the component'
    value :POWER_STATE, 'The power state of the component'
    value :PRESSURE, 'The current pressure'
    value :RESET, 'The statistical reset event'
    value :PROGRAM, 'The name of the program being run'
    value :PROGRAM_COMMENT, 'A comment in the control program'
    value :ROTARY_MODE, 'The function of the rotary axis'
    value :COUPLED_AXES, 'The axes to which this axis is associated'
    value :AXIS_COUPLING, 'The method the axes are coupled together'
    value :SPINDLE_SPEED, 'DEPRECATED: The velocity of the spindle'
    value :TEMPERATURE, 'The temperature of the component'
    value :TORQUE, 'The torque - force times distance'
    value :TOOL_ASSET_ID, 'The unique asset identifier of the tool in use'
    value :TOOL_ID, 'DEPRECATED: Use TOOL_ASSET_ID'
    value :TOOL_NUMBER, 'The number of the tool as represented by the contoller T#'
    value :VELOCITY, 'The velocity of the component'
    value :VIBRATION, 'The status indicator'
    value :VOLTAGE, 'The voltage'
    value :WATTAGE, 'The wattage'

    # Types for 1.2
    value :ACCUMULATED_TIME, 'The non-contiguous accumulation of time'
    value :ACTUATOR_STATE, 'The state of the actuator. ACTIVE or INACTIVE.'
    value :ASSET_CHANGED, 'A new asset has been added'
    value :CONCENTRATION, 'Percentage of one component within a mixture of components'
    value :CONDUCTIVITY, 'The conductivity of a piece of material'
    value :DISPLACEMENT, 'The displacement as measured from zero to peak'
    value :ELECTRICAL_POWER, 'Electrical power as measured in Watt-Seconds'
    value :FILL_LEVEL, 'The measurement of the amount of a substance remaining compared to the planned maximum amount of that substance'
    value :FLOW, 'The rate of flow of a fluid'
    value :LINEAR_FORCE, 'The measure of the push or pull introduced by an actuator or exerted on an object'
    value :MASS, 'The weight of some object in kilograms'
    value :PH, 'The measure of ion concentration in a substance; a measure of the acidity or alkalinity of a solution.'
    value :POWER_FACTOR, 'The ratio of the real power flowing in a circuit to the apparent power in the circuit'
    value :RESISTANCE, 'The measurement of the degree to which an object opposes an electric current through it'
    value :ROTARY_VELOCITY, 'The rotational speed of a rotary axis.'
    value :SOUND_PRESSURE, 'Measurement of acoustic pressure'
    value :STRAIN, 'Inches / Inch - dimensional change - measured under pressure or tension. micro change in length'
    value :TILT, 'micrometer/meter (alignment errors of axes or spindle errors)'
    value :VOLT_AMPERE, 'The measure of the apparent power in an electrical circuit, equal to the product of root-mean-square (RMS) voltage and RMS current'
    value :VOLT_AMPERE_REACTIVE, 'The measurement of measure reactive power in an AC electrical circuit'
    value :WATT_SECOND, 'The measure of watts for one second, equivilent to joules'
    value :VISCOSITY, 'viscosity'

    # Condition types
    value :COMMUNICATIONS, 'The communications system'
    value :LOGIC_PROGRAM, 'The logic program'
    value :MOTION_PROGRAM, 'The motion program'
    value :HARDWARE, 'The computer hardware has failed'
    value :SYSTEM, 'A system level condition'
    value :LEVEL, 'The level of a resource'
    value :ACTUATOR, 'An actuator related condition'
    
    # 1.3 general changes
    value :ROTARY_VELOCITY_OVERRIDE, 'The override percent for the spindle speed'
    value :PATH_FEEDRATE_OVERRIDE, 'The override percent for the spindle speed'
    value :PART_ASSET_ID, 'The identifier of the part loaded'
    value :PROGRAM_EDIT, 'The state of the devices editor'
    value :PROGRAM_EDIT_NAME, 'The name of the program being edited'
    
    # 1.3 additions
    value :CHUCK_STATE, 'A state of a chuck'
    value :END_OF_BAR, 'Indicator that the end of material has been reached'
    value :AUXILIARY_END_OF_BAR, 'Indicator that the end of material has been reached, but more material remains'
    value :AXIS_INTERLOCK, 'Spindle interlock indicator'
    value :MANUAL_CHUCK_UNCLAMP_INTERLOCK, 'Prevent the chuck from unclamping'
    value :LENGTH, 'Represents the length of the material'
    value :AXIS_STATE, 'The home or travel state of the axis'
    value :INTERFACE_STATE, 'The state of the interface'
    value :FUNCTIONAL_MODE, 'The current function of the device'
    value :WORKHOLDING_ID, 'The workholding identifier'
    value :PALLET_ID, 'The identifier of the pallet currently being used'
    value :OPERATOR_ID, 'The identifier of the operator'
    value :ASSET_REMOVED, 'The asset event when an asset is removed'
    value :PROGRAM_HEADER, 'The header of a program'

    # 1.3 Interfaces
    value :MATERIAL_FEED, 'Feed material'
    value :MATERIAL_CHANGE, 'Change the material'
    value :MATERIAL_RETRACT, 'Change the material'
    value :PART_CHANGE, 'Change the part on the bar feeder - changes the job being run'
    value :OPEN_DOOR, 'Open a door'
    value :CLOSE_DOOR, 'Close a door'
    value :OPEN_CHUCK, 'Open a chuck'
    value :CLOSE_CHUCK, 'Close a chuck'
    value :MATERIAL_LOAD, 'Load material into a device'
    value :MATERIAL_UNLOAD, 'Unload material into a device'
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    extensible :DataItemExt
    
    value :ACTUAL, 'The actual position with absolute coordinates'
    value :COMMANDED, 'The expected value from the controller'
    value :MAXIMUM, 'The maximum value for this measurement'
    value :MINIMUM, 'The minimum value for this measurement'
    value :OTHER, 'An extension point'
    value :OVERRIDE, 'DEPRECATED 1.3: The override for the measurement'
    value :PROBE, 'The position given by a probe'
    value :TARGET, 'The target position'
    value :GOOD, 'The good count'
    value :BAD, 'The bad count'
    value :ALL, 'Inclusive of all items'
    value :LINE, 'The high voltage subtype for power state'
    value :CONTROL, 'The low voltage subtype for power state'
    
    value :ALTERNATING, 'Corresponds to an alternating current'
    value :DIRECT, 'Corresponds to an alternating current'
    
    # For 1.2
    value :WEIGHT, 'Concentration in weight'
    value :VOLUME, 'Concentration in volume'
    value :MOLE, 'Concentration in mole'
    value :KINETIC, 'Kenetic viscosity'
    value :DYNAMIC, 'Dynamic viscosity'

    # For 1.2 sound level
    value :NO_SCALE, 'No weighting factor on the frequency scale'
    value :A_SCALE, 'A Scale weighting factor.   This is the default weighting factor if no factor is specified'
    value :B_SCALE, 'B Scale weighting factor'
    value :C_SCALE, 'C Scale weighting factor'
    value :D_SCALE, 'D Scale weighting factor'
    
    # For 1.3 Interface
    value :REQUEST, 'The request side of the interface'
    value :RESPONSE, 'The response side of the interface'
    value :REMAINING, 'The measurement represents the amount remaining'
    
    # For end of bar
    value :PRIMARY, 'The primary value for this data item'
    value :AUXILIARY, 'The auxiliary value for this data item'

    value :MANUAL_UNCLAMP, 'The component cannot be manually unclamped'
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
    value :RANGE, 'The difference between the maximum and minimum value during the calculated period'
    value :KURTOSIS, 'In probability theory and statistics, kurtosis is a measure of the "peakedness" of the probability distribution'
  end
  
  # Common Units
  basic_type(:UnitsExt, 'An extension point for data item types') do
    pattern 'x:[A-Z_0-9]+'
  end

  enum :Units, 'The units supported' do
    extensible :UnitsExt
    
    value :AMPERE, 'The electrical current'
    value :CELSIUS, 'Degrees Celcius'
    value :COUNT, 'A counted event'
    value :DEGREE, 'Angle in degrees'
    value :'DEGREE/SECOND', 'Degrees per  second'
    value :'DEGREE/SECOND^2', 'Degrees per second squared'
    value :HERTZ, 'Cycles per second'
    value :JOULE, 'A measure of energy'
    value :KILOGRAM, 'Kilograms'
    value :LITER, 'Liters'
    value :'LITER/SECOND', 'Liters per second'
    value :MILLIMETER, 'Millimeters'
    value :'MILLIMETER/SECOND', 'Millimeters per second'
    value :'MILLIMETER/SECOND^2', 'Acceleration at millimeters per second squared'
    value :MILLIMETER_3D, '3D Millimeters'
    value :NEWTON, 'Force in Newtons'
    value :NEWTON_METER, 'A unit for force times distance. The SI units will be used in Newton meters.'
    value :PASCAL, 'Pressure in Newtons per square meter'
    value :PERCENT, 'A percentage'
    value :PH, 'pH is a measure of hydrogen ion concentration; a measure of the acidity or alkalinity of a solution.'
    value :'REVOLUTION/MINUTE', 'Revolutions per minute'
    value :SECOND, 'Seconds'
    value :VOLT, 'The voltage'
    value :WATT, 'The wattage'
    
    # For 1.2
    value :OHM, 'Electrical resistance'
    value :SOUND_LEVEL, 'Sound pressure - a sound pressure level of .0002 microbar'
    value :'SIEMENS/METER', 'Conductivity'
    value :'MICRO_RADIAN', 'Angular motion for tilt'
    value :'PASCAL_SECOND', 'Measure of viscosity'
    value :VOLT_AMPERE, 'A volt ampere'
    value :VOLT_AMPERE_REACTIVE, 'A volt ampere reactive'
    value :WATT_SECOND, 'A measure of energy equivilent to one Joule or 1/3,600,000 kilowatt hour'
    value :DECIBEL, 'Sound level    '
  end

  enum :NativeUnits, 'The units supported for the source equipment that can be converted into MTC Units.', :Units do
    # Alternate types for the source system.
    extensible :UnitsExt
    
    value :CENTIPOISE, 'A measure of viscosity'
    value :'DEGREE/MINUTE', 'Feedrate in degrees per minute'
    value :FAHRENHEIT, 'Degrees Fahrenheit'
    value :FOOT, 'Feet'
    value :'FOOT/MINUTE', 'Feet per minute'
    value :'FOOT/SECOND', 'Feet per second'
    value :'FOOT/SECOND^2', 'Feet per second'
    value :FOOT_3D, '3D Foot'
    value :'GALLON/MINUTE', 'Gallons per minute'
    value :INCH, 'Inches'
    value :'INCH/MINUTE', 'Inches per minute'
    value :'INCH/SECOND', 'Inches per second'
    value :'INCH/SECOND^2', 'Inches per second'
    value :INCH_3D, '3D Inches'
    value :KILOWATT, 'Kilowatts'
    value :'KILOWATT_HOUR', 'kilowatt hours'
    value :'MILLIMETER/MINUTE', 'Feedrate in millimeters per minute'
    value :OTHER, 'Other units (Cannot be converted)'
    value :POUND, 'Pounds'
    value :'POUND/INCH^2', 'Pressure in pounds per square inch'
    value :RADIAN, 'Radians'
    value :'RADIAN/MINUTE', 'Radians per minute'
    value :'RADIAN/SECOND', 'Radians per second'
    value :'RADIAN/SECOND^2', 'Radians per second'
    value :'REVOLUTION/SECOND', 'Spindle speed in revolutions per Second'
  end
  
  enum :CoordinateSystem, 'The coordinate system to be used for the position' do
    value :MACHINE, '	An unchangeable coordinate system that has machine zero as its origin'
    value :WORK, 'The position that acts as the origin for a particular workpiece'
  end
  
end
