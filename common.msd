# coding: utf-8


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
  attr :Name, 'A short name for any element', :NMTOKEN
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumberAttr, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ComponentId, 'The id of the component (maps to the id from probe)', :ID
  attr :ID, 'An identifier', :ID
  attr :SignificantDigitsValue, 'The number significant digits', :integer
  attr :CompositionId, 'The item\'s reference to the Device model composition', :NMTOKEN
  
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

    # Samples 
    value :ACCELERATION, 'The accelleration of the component'
    value :ACCUMULATED_TIME, 'The non-contiguous accumulation of time'
    value :ANGULAR_ACCELERATION, 'The accelleration of the component'
    value :ANGULAR_VELOCITY, 'The velocity of the component'
    value :AMPERAGE, 'The electrical current'
    value :ANGLE, 'The position as given in degrees'
    value :AXIS_FEEDRATE, 'The feedrate for the axis'
    value :CLOCK_TIME, 'The wall clock time'
    value :CONCENTRATION, 'Percentage of one component within a mixture of components'
    value :CONDUCTIVITY, 'The conductivity of a piece of material'
    value :DISPLACEMENT, 'The displacement as measured from zero to peak'
    value :ELECTRICAL_ENERGY, 'Electrical power as measured in Watt-Seconds'
    value :EQUIPMENT_TIMER, 'The measurement of the amount of time a piece of equipment or a sub-part of a piece of equipment has performed specific activities'
    value :FILL_LEVEL, 'The measurement of the amount of a substance remaining compared to the planned maximum amount of that substance'
    value :FLOW, 'The rate of flow of a fluid'
    value :FREQUENCY, 'The frequency as measure in cycles per second'
    value :LENGTH, 'Represents the length of the material'
    value :LINEAR_FORCE, 'The measure of the push or pull introduced by an actuator or exerted on an object'
    value :LOAD, 'The load on the component as a percentage of rated'
    value :MASS, 'The weight of some object in kilograms'
    value :PATH_FEEDRATE, 'The feedrate for the path'
    value :PATH_POSITION, 'The three space position X, Y, Z'
    value :PH, 'The measure of ion concentration in a substance; a measure of the acidity or alkalinity of a solution.'
    value :POSITION, 'The position as given in mm'
    value :POWER_FACTOR, 'The ratio of the real power flowing in a circuit to the apparent power in the circuit'
    value :PRESSURE, 'The current pressure'
    value :PROCESS_TIMER, 'The measurement of the amount of time a piece of equipment has performed different types of activities associated with the process'
    value :RESISTANCE, 'The measurement of the degree to which an object opposes an electric current through it'
    value :ROTARY_VELOCITY, 'The rotational speed of a rotary axis.'
    value :SOUND_LEVEL, 'Measurement of acoustic pressure'
    value :SPINDLE_SPEED, 'DEPRECATED: The velocity of the spindle'
    value :STRAIN, 'Inches / Inch - dimensional change - measured under pressure or tension. micro change in length'
    value :TEMPERATURE, 'The temperature of the component'
    value :TENSION, 'A measurement of a force that stretches or elongates an object'
    value :TILT, 'micrometer/meter (alignment errors of axes or spindle errors)'    
    value :TORQUE, 'The torque - force times distance'
    value :VELOCITY, 'The velocity of the component'
    value :VISCOSITY, 'viscosity'
    value :VOLTAGE, 'The voltage'
    value :VOLT_AMPERE, 'The measure of the apparent power in an electrical circuit, equal to the product of root-mean-square (RMS) voltage and RMS current'
    value :VOLT_AMPERE_REACTIVE, 'The measurement of measure reactive power in an AC electrical circuit'
    value :WATTAGE, 'The wattage'
    
    # Events
    value :ACTIVE_AXES, 'The list of axes currently in use in this path'
    value :ACTUATOR_STATE, 'The state of the actuator. ACTIVE or INACTIVE.'
    value :ALARM, 'DEPRECATED: An alarm'
    value :AVAILABILITY, 'The components availability'
    value :AXIS_COUPLING, 'The method the axes are coupled together'
    value :AXIS_FEEDRATE_OVERRIDE, 'The override percent for the spindle speed'
    value :AXIS_INTERLOCK, 'Spindle interlock indicator'
    value :AXIS_STATE, 'The home or travel state of the axis'
    value :BLOCK, 'The current executing block'
    value :BLOCK_COUNT, 'The number of blocks executed since the cycle start'
    value :CHUCK_STATE, 'A state of a chuck'
    value :CODE, 'DEPRECATED: The current executing code'
    value :COMPOSITION_STATE, 'An indication of the operating condition of a mechanism represented by a Composition type element'
    value :CONTROLLER_MODE, 'The CNC\'s mode'
    value :CONTROLLER_MODE_OVERRIDE, 'A setting or operator selection that changes the behavior of a piece of equipment'
    value :COUPLED_AXES, 'The axes to which this axis is associated'
    value :DIRECTION, 'The direction of rotation or linear motion'
    value :DOOR_STATE, 'The open/closed state of the door'
    value :DRY_RUN, 'The controller is executing the program but suppressing motion'
    value :EMERGENCY_STOP, 'The state of the ESTOP button'
    value :EQUIPMENT_MODE, 'An indication that a piece of equipment, or a sub-part of a piece of equipment, is performing specific types of activities'
    value :EXECUTION, 'The programs execution state'
    value :FUNCTIONAL_MODE, 'The current function of the device'
    value :HARDNESS, 'The measurement of the hardness of a material'
    value :LEVEL, 'The level of a resource'
    value :LINE, 'DEPRECATED 1.4: The line of the program being executed – often referred to as the N number'
    value :LINE_LABEL, 'The label or N number of the position within the program'
    value :LINE_NUMBER, 'The absolute or relative block number position in the program. Relative is relative to a line label.'
    value :MATERIAL, 'The identifier of a material used or consumed in the manufacturing process'
    value :MESSAGE, 'A uninterpreted message'
    value :OPERATOR_ID, 'The identifier of the operator'
    value :PALLET_ID, 'The identifier of the pallet currently being used'
    value :PART_ASSET_ID, 'The identifier of the part loaded'
    value :PART_COUNT, 'A count of the parts'
    value :PART_ID, 'The identifier of the part loaded'
    value :PART_NUMBER, 'An identifier of a part or product moving through the manufacturing process'
    value :PATH_FEEDRATE_OVERRIDE, 'The override percent for the spindle speed'
    value :PATH_MODE, 'The mode of the path'
    value :POWER_STATE, 'The power state of the component'
    value :POWER_STATUS, 'DEPRECATED: The power status of the component'
    value :PROGRAM, 'The name of the program being run'
    value :PROGRAM_COMMENT, 'A comment in the control program'
    value :PROGRAM_EDIT, 'The state of the devices editor'
    value :PROGRAM_EDIT_NAME, 'The name of the program being edited'
    value :PROGRAM_HEADER, 'The header of a program'
    value :ROTARY_MODE, 'The function of the rotary axis'
    value :ROTARY_VELOCITY_OVERRIDE, 'The override percent for the spindle speed'
    value :SERIAL_NUMBER, 'The serial number associated with a Component, Asset, or Device'
    value :SPINDLE_INTERLOCK, 'An indication of the status of the spindle for a piece of equipment when power has been removed and it is free to rotate'
    value :TOOL_ASSET_ID, 'The unique asset identifier of the tool in use'
    value :TOOL_ID, 'DEPRECATED: Use TOOL_ASSET_ID'
    value :TOOL_NUMBER, 'The number of the tool as represented by the contoller T#'
    value :TOOL_OFFSET, 'A reference to the tool offset variables applied to the active cutting tool associated with a Path in a Controller type component'
    value :USER, 'The user of the device or applicaiton'
    value :WIRE, 'The identifier for the type of wire used as the cutting mechanism in Electrical Discharge Machining or similar processes'
    value :WORKHOLDING_ID, 'The workholding identifier'
    value :WORK_OFFSET, 'A reference to the offset variables for a work piece or part associated with a Path in a Controller type component.'

    # Conditions
    value :ACTUATOR, 'An actuator related condition'
    value :CHUCK_INTERLOCK, 'An indication of the state of an interlock function'
    value :COMMUNICATIONS, 'The communications system'
    value :DATA_RANGE, 'An indication that the value of the data associated with a measured value or a calculation is outside of an expected range'
    # Direction
    value :END_OF_BAR, 'Indicator that the end of material has been reached'
    value :HARDWARE, 'The computer hardware has failed'
    value :INTERFACE_STATE, 'An indication of the operation condition of an Interface component.'
    value :LOGIC_PROGRAM, 'The logic program'
    value :MOTION_PROGRAM, 'The motion program'
    value :SYSTEM, 'A system level condition'    

    # Asset Related
    value :ASSET_CHANGED, 'A new asset has been added'
    value :ASSET_REMOVED, 'The asset event when an asset is removed'

    # Interface Related
    value :AUXILIARY_END_OF_BAR, 'Indicator that the end of material has been reached, but more material remains'
    value :CLOSE_CHUCK, 'Close a chuck'
    value :CLOSE_DOOR, 'Close a door'
    value :INTERFACE_STATE, 'The state of the interface'    
    value :MACHINE_AXIS_LOCK, 'The controller is in the machine axis lock state'
    value :MANUAL_CHUCK_UNCLAMP_INTERLOCK, 'Prevent the chuck from unclamping'
    value :MATERIAL_CHANGE, 'Change the material'
    value :MATERIAL_FEED, 'Feed material'
    value :MATERIAL_LOAD, 'Load material into a device'
    value :MATERIAL_RETRACT, 'Change the material'
    value :MATERIAL_UNLOAD, 'Unload material into a device'
    value :OPEN_CHUCK, 'Open a chuck'
    value :OPEN_DOOR, 'Open a door'
    value :PART_CHANGE, 'Change the part on the bar feeder - changes the job being run'

    # Questionable
    value :RESET, 'The statistical reset event'
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    extensible :DataItemExt
    
    value :ABSOLUTE, 'The absolute physical position in the program '
    value :ACTUAL, 'The actual position with absolute coordinates'
    value :ACTION, 'An indication of the operating condition of a mechanism represented by a Composition type element'
    value :ALL, 'Inclusive of all items'
    value :ALTERNATING, 'Corresponds to an alternating current'
    value :AUXILIARY, 'The auxiliary value for this data item'
    value :A_SCALE, 'A Scale weighting factor.   This is the default weighting factor if no factor is specified'
    value :BAD, 'The bad count'
    value :BRINELL, 'A scale to measure the resistance to deformation of a surface'
    value :B_SCALE, 'B Scale weighting factor'
    value :COMMANDED, 'The expected value from the controller'
    value :CONTROL, 'The low voltage subtype for power state'
    value :C_SCALE, 'C Scale weighting factor'
    value :DELAY,'Measurement of the time that a piece of equipment is waiting for an event'
    value :DIRECT, 'Corresponds to an alternating current'
    value :DRY_RUN, 'A setting or operator selection used to execute a test mode to confirm the execution of machine functions'
    value :DYNAMIC, 'Dynamic viscosity'
    value :D_SCALE, 'D Scale weighting factor'
    value :FIXTURE, 'Fixture coordinates are being transformed.'
    value :GOOD, 'The good count'
    value :JOG, 'Manual movement'
    value :INCREMENTAL, 'The position of a block of program code relative to the occurrence of the last LINE_LABEL encountered in the control program'
    value :KINETIC, 'Kenetic viscosity'
    value :LATERAL, 'An indication of the position of a mechanism that may move in a lateral direction'
    value :LEEB, 'A scale to measure the resistance to deformation of a surface'
    value :LENGTH, 'A reference to a length type tool offset variable'
    value :LINE, 'The high voltage subtype for power state'
    value :LINEAR, 'The direction of motion of a linear device'
    value :LOADED, 'Measurement of the time that the sub-parts of a piece of equipment are under load'
    value :MACHINE_AXIS_LOCK, 'A setting or operator selection that changes the behavior of the controller on a piece of equipment'
    value :MAINTENANCE, 'The identifier of the person currently responsible for performing maintenance'
    value :MANUAL_UNCLAMP, 'The component cannot be manually unclamped'
    value :MAXIMUM, 'The maximum value for this measurement'
    value :MINIMUM, 'The minimum value for this measurement'
    value :MOHS, 'A scale to measure the resistance to deformation of a surface'
    value :MOLE, 'Concentration in mole'
    value :MOTION, 'An indication of the open or closed state of a mechanism'
    value :NO_SCALE, 'No weighting factor on the frequency scale'
    value :OPERATOR, 'The identifier of the person currently responsible for operating'
    value :OPERATING, 'Measurement of the time that the major sub-parts of a piece of equipment are powered or performing an activity'
    value :OPTIONAL_STOP, 'A setting or operator selection that changes the behavior of the controller on a piece of equipment'
    value :TOOL_CHANGE_STOP, 'A setting or operator selection that changes the behavior of the controller on a piece of equipment'
    value :OVERRIDE, 'DEPRECATED 1.3: The override for the measurement'
    value :PRIMARY, 'The primary value for this data item'
    value :PROBE, 'The position given by a probe'
    value :PROGRAMMED, 'A programmed position or override effecting the given value'
    value :POWERED, 'The measurement of time that primary power is applied to the piece of equipment'
    value :PROCESS, 'The measurement of the time from the beginning of production of a part or product'
    value :RADIAL, 'A reference to a length type tool offset variable'
    value :RAPID, 'Rapid movement'
    value :RELATIVE, 'The relative position in the program to the last line (N) number'
    value :REMAINING, 'The measurement represents the amount remaining'
    value :REQUEST, 'The request side of the interface'
    value :RESPONSE, 'The response side of the interface'
    value :ROCKWELL, 'A scale to measure the resistance to deformation of a surface'
    value :ROTARY, 'The rotational direction of a rotary device using the right hand rule convention'
    value :SET_UP, 'The identifier of the person currently responsible for setting up'
    value :SHORE, 'A scale to measure the resistance to deformation of a surface.'
    value :SINGLE_BLOCK, 'A setting or operator selection that changes the behavior of the controller on a piece of equipment'
    value :STANDARD, 'The standard or original length of an object'
    value :SWITCHED, 'An indication of the activation state of a mechanism represented by a Composition type component'
    value :TARGET, 'The target position'
    value :TOOL, 'Tool coordinates are being transformed.'
    value :USABLE, 'The remaining useable length of an object'
    value :VERTICAL, 'An indication of the position of a mechanism that may move in a vertical direction'
    value :VICKERS, 'A scale to measure the resistance to deformation of a surface'
    value :VOLUME, 'Concentration in volume'
    value :WORKING, 'Measurement of the time that a piece of equipment is performing any activity'
  end
  
  enum :DataItemStatistics, 'Statistical operations on data' do
    extensible :DataItemStatsExt
    
    value :AVERAGE, 'The average'    
    value :KURTOSIS, 'In probability theory and statistics, kurtosis is a measure of the "peakedness" of the probability distribution'
    value :MAXIMUM, 'The maximum value'
    value :MEDIAN, 'The middle number of a series'
    value :MODE, 'The mode of the sample'
    value :MINIMUM, 'The minimum value'
    value :RANGE, 'The difference between the maximum and minimum value during the calculated period'
    value :ROOT_MEAN_SQUARE, 'The root mean square'
    value :STANDARD_DEVIATION, 'The standard deviation'
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
    value :DECIBEL, 'Sound level    '
    value :DEGREE, 'Angle in degrees'
    value :'DEGREE/SECOND', 'Degrees per  second'
    value :'DEGREE/SECOND^2', 'Degrees per second squared'
    value :HERTZ, 'Cycles per second'
    value :JOULE, 'A measure of energy'
    value :KILOGRAM, 'Kilograms'
    value :LITER, 'Liters'
    value :'LITER/SECOND', 'Liters per second'
    value :MICRO_RADIAN, 'Angular motion for tilt'
    value :MILLIMETER, 'Millimeters'
    value :'MILLIMETER/SECOND', 'Millimeters per second'
    value :'MILLIMETER/SECOND^2', 'Acceleration at millimeters per second squared'
    value :MILLIMETER_3D, '3D Millimeters'
    value :NEWTON, 'Force in Newtons'
    value :NEWTON_METER, 'A unit for force times distance. The SI units will be used in Newton meters.'
    value :OHM, 'Electrical resistance'
    value :PASCAL, 'Pressure in Newtons per square meter'
    value :PASCAL_SECOND, 'Measure of viscosity'
    value :PERCENT, 'A percentage'
    value :PH, 'pH is a measure of hydrogen ion concentration; a measure of the acidity or alkalinity of a solution.'
    value :'REVOLUTION/MINUTE', 'Revolutions per minute'
    value :SECOND, 'Seconds'
    value :'SIEMENS/METER', 'Conductivity'
    value :SOUND_LEVEL, 'Sound pressure - a sound pressure level of .0002 microbar'
    value :VOLT, 'The voltage'
    value :VOLT_AMPERE, 'A volt ampere'
    value :VOLT_AMPERE_REACTIVE, 'A volt ampere reactive'
    value :WATT, 'The wattage'
    value :WATT_SECOND, 'A measure of energy equivilent to one Joule or 1/3,600,000 kilowatt hour'
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
  
  basic_type(:DataItemResetValueExt, 'An extension point for reset types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  enum :DataItemResetValue, 'The reset intervals' do
    extensible :DataItemResetValueExt
    
    value :ACTION_COMPLETE, 'The item was reset at the beginning of an activity'
    value :ANNUAL, 'Counter starts at the beginning of a yearly cycle'
    value :DAY, 'Reset every day'
    value :LIFE, 'The value of the data item is not reset and accumulates for the entire life of the piece of equipment'
    value :MAINTENANCE, 'Reset when Maintainence occurs'
    value :MANUAL, 'Reset manually'
    value :MONTH, 'Counter starts at the beginning of a montly cycle'
    value :POWER_ON, 'Count starts at time the machine powers on'
    value :SHIFT, 'Counter starts at the beginning of a shift'
    value :WEEK, 'Counter starts at the beginning of a weekly cycle'
  end
  
end
