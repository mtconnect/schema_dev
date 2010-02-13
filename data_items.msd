
package :DataItems, 'Data Items Package' do
  attr :SampleRate, 'The rate a measurement is sampled', :float
  attr :DataItemOption, 'The constrained value for this data item'
  attr :DataItemValue, 'The constrained value for this data item'
  attr :SignificantDigitsValue, 'The number significant digits', :integer
  
  
  # Measurement types
  enum :Category, 'The measurement sampling type' do
    value :EVENT, 'An event represents a change in state occurs at a point in time. Note: An event does not occur at predefined frequencies.'
    value :SAMPLE, 'A sample is a data point for continuous data items, that is, the value of a data item at a point in time.'
  end

  attr :NativeScale, 'The multiplier for the native value. Conversion divides by this value', :float

  # Data item types and sub types have been moved to common.

  enum :Units, 'The units supported' do
    value :STATUS, 'A status value'
    value :MILLIMETER, 'Millimeters'
    value :MILLIMETER_3D, '3D Millimeters'
    value :DEGREE, 'Angle in degrees'
    value :DEGREE_3D, '3D Angle in degrees'
    value :'MILLIMETER/SECOND', 'Millimeters per second'
    value :'DEGREE/SECOND', 'Degrees per  second'
    value :'MILLIMETER/SECOND^2', 'Acceleration at millimeters per second squared'
    value :'DEGREE/SECOND^2', 'Degrees per second squared'
    value :LITER, 'Liters'
    value :KILOGRAM, 'Kilograms'
    value :NEWTON, 'Force in Newtons'
    value :CELSIUS, 'Degrees Celcius'
    value :'REVOLUTION/MINUTE', 'Revolutions per minute'
    value :VOLT, 'The voltage'
    value :AMPERE, 'The electrical current'
    value :WATT, 'The wattage'
    value :PART_COUNT, 'The number of parts produced'
    value :PASCAL, 'Pressure in Newtons per square meter'
    value :PERCENT, 'A percentage'
    value :NEWTON_METER, 'A unit for force times distance. The SI units will be used in Newton meters.'
  end

  enum :NativeUnits, 'The units supported for the source equipment that can be converted into MTC Units.', :Units do
    # Alternate types for the source system.
    value :INCH, 'Inches'
    value :'INCH/MINUTE', 'Inches per minute'
    value :'INCH/SECOND', 'Inches per second'
    value :'INCH/SECOND^2', 'Inches per second'
    value :INCH, 'Inches'
    value :INCH_3D, '3D Inches'
    value :FOOT, 'Feet'
    value :'FOOT/MINUTE', 'Feet per minute'
    value :'FOOT/SECOND', 'Feet per second'
    value :'FOOT/SECOND^2', 'Feet per second'
    value :FOOT_3D, '3D Foot'
    value :POUND, 'Pounds'
    value :FAHRENHEIT, 'Degrees Fahrenheit'
    value :RADIAN, 'Radians'
    value :RADIAN_3D, '3D Radians'
    value :'RADIAN/SECOND', 'Radians per second'
    value :'RADIAN/SECOND^2', 'Radians per second'
    value :'RADIAN/MINUTE', 'Radians per minute'
    value :'MILLIMETER/MINUTE', 'Feedrate in millimeters per minute'
    value :'DEGREE/MINUTE', 'Feedrate in degrees per minute'
    value :'REVOLUTION/SECOND', 'Spindle speed in revolutions per Second'
    value :OTHER, 'Other units (Cannot be converted)'
  end
  
  enum :CoordinateSystem, 'The coordinate system to be used for the position' do
    value :MACHINE, '	An unchangeable coordinate system that has machine zero as its origin'
    value :WORK, 'The position that acts as the origin for a particular workpiece'
  end

  # Measurement types
  
  type :DataItems, 'A generic list of measurements for all axis' do
    member :DataItem, 'A measurement for this component', 1..INF
  end

  type :DataItem, 'A abstract measurement' do
    member :Name, 'The name of the measurement. ' do
      standards :OMAC => 'label'
    end
    member :id, 'The data item identifier', :ID
    member :Type, 'The type of measurement', :DataItemEnum
    member :SubType, 'The sub type for the measurement', 0..1, :DataItemSubEnum
    member :Units, 'The units of the measurement', 0..1
    member :NativeUnits, 'The units as expressed by the machine', 0..1
    member :NativeScale, 'The units as expressed by the machine', 0..1
    member :Category, 'The category of the data item'
    member :Source, 'The measurement\'s source. This is the native machine identifier for this measurement. The source will be used to identify the correct incoming value with the measurement.', 0..1
    member :CoordinateSystem, 'The coordinate system used for the positions', 0..1
    member :SignificantDigits, 'The number of significant digits for this data item', 0..1, :SignificantDigitsValue
    member :Constraints, 'Limits on the set of possible values', 0..1, :DataItemLimits
  end

  type :DataItemLimits, 'A set of limits for a data item' do
    choice do
      set do
        member :Value, 'An possible value for this data item. Used for controlled vocabularies.', 1..INF, :DataItemValueElement
      end
      set do
        member :Minimum, 'A minimum value for this data item.', :DataItemValue
        member :Maximum, 'A maximum value for this data item.', :DataItemValue
      end
    end
  end
  
  type :DataItemValueElement, 'The value element' do
    member :Value, 'A possible value for this data item', :DataItemOption
  end
  
  type :Source, 'A native data source' do
    member :Value, 'The source', :ItemSource
  end

end
