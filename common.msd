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
  attr :Name, 'A short name for any element'
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumberAttr, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ComponentId, 'The id of the component (maps to the id from probe)', :ID
  attr :ID, 'An identifier', :ID
  attr :SignificantDigitsValue, 'The number significant digits', :integer
  attr :CompositionId, 'The item\'s reference to the Device model composition', :NMTOKEN
  attr :DurationTime, 'A length of time in seconds', :float
  
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

    Glossary.events.each do |e|
      value(e.keys['name'], e.keys['description'])
    end

    Glossary.samples.each do |e|
      value(e.keys['name'], e.keys['description'])
    end

    Glossary.conditions.each do |e|
      value(e.keys['name'], e.keys['description'])
    end
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    extensible :DataItemExt
    
    Glossary.subtypes.each do |e|
      value(e.keys['name'], e.keys['description'])
    end
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
  
  basic_type(:DataItemResetValueExt, 'An extension point for reset types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  enum :DataItemResetValue, 'The reset intervals' do
    extensible :DataItemResetValueExt
    
    value :ACTION_COMPLETE, 'The item was reset at the beginning of an activity'
    value :ANNUAL, 'Counter starts at the beginning of a yearly cycle'
    value :DAY, 'Reset every day'
    value :MAINTENANCE, 'Reset when Maintainence occurs'
    value :MANUAL, 'Reset manually'
    value :MONTH, 'Counter starts at the beginning of a montly cycle'
    value :POWER_ON, 'Count starts at time the machine powers on'
    value :SHIFT, 'Counter starts at the beginning of a shift'
    value :WEEK, 'Counter starts at the beginning of a weekly cycle'
  end
  
end
