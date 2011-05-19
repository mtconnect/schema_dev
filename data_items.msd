
package :DataItems, 'Data Items Package' do
  attr :SampleInterval, 'The interval between adjacent sampleing of data', :float
  attr :SampleRate, 'The frequency a measurement is sampled', :float
  attr :DataItemOption, 'The constrained value for this data item'
  attr :DataItemValue, 'The constrained value for this data item'
  attr :SignificantDigitsValue, 'The number significant digits', :integer  
  
  # Measurement types
  enum :Category, 'The measurement sampling type' do
    value :EVENT, 'An event represents a change in state occurs at a point in time. Note: An event does not occur at predefined frequencies.'
    value :SAMPLE, 'A sample is a data point for continuous data items, that is, the value of a data item at a point in time.'
    value :CONDITION, 'The condition of the device'
    value :INTERFACE, 'A data item representing an interface'
  end

  attr :NativeScale, 'The multiplier for the native value. Conversion divides by this value', :float

  # Data item types and sub types have been moved to common.  
  enum :Representation, 'The possible representations of a DataItem' do
    value :VALUE, 'A singluar value or fixed length value is give'
    value :TIME_SERIES, 'A waveform'
  end

  # Measurement types
  
  type :DataItems, 'A generic list of measurements for all axis' do
    member :DataItem, 'A measurement for this component', 1..INF
  end

  type :DataItem, 'A abstract measurement' do
    member :Name, 'The optional implementors name of the measurement.', 0..1
    member :id, 'The data item identifier', :ID
    member :Type, 'The type of measurement', :DataItemEnum
    member :SubType, 'The sub type for the measurement', 0..1, :DataItemSubEnum
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
    member :Units, 'The units of the measurement', 0..1
    member :NativeUnits, 'The units as expressed by the machine', 0..1
    member :NativeScale, 'The units as expressed by the machine', 0..1
    member :Category, 'The category of the data item'
    member :Source, 'Additional information about the component, channel, register, etc... that collects the data.', 0..1
    member :CoordinateSystem, 'The coordinate system used for the positions', 0..1
    member :SampleRate, 'Used as the default sample rate for waveforms', 0..1
    member(:Representation, 'The data item\'s representation', 0..1) { self.default = :VALUE } 
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
    member :ComponentId, 'The component that is collecting the data associated with this data item', 0..1
    member :Value, 'The source or channel for this data', :ItemSource
  end

end
