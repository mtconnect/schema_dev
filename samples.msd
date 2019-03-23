
package :Samlpes, 'The samples' do
  float = '[+-]?\d+(\.\d+)?([Ee][+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  int_value = "[+-]?\d+|UNAVAILABLE"
  vector_value = "(#{float}( )*)+|UNAVAILABLE"
  
  basic_type :SampleValue, 'An floating point value or array of floating point values'
  basic_type(:FloatValue, 'The value for the position') { pattern float_value }
  basic_type(:TimeSeriesValue, 'A time series') { pattern vector_value }
  basic_type(:ThreeDimensionalValue, 'A three dimensional value \'X Y Z\' or \'A B C\'') { pattern "#{float} #{float} #{float}|UNAVAILABLE" }
  basic_type(:DurationValue, 'The duration of an event in seconds') { pattern float_value }
  basic_type(:SampleRate, 'The sampling rate in samples per second') { pattern float_value }  
  basic_type(:CountValue, 'The number of values') { pattern int_value }  
  
  type :Sample, 'An abstract sample', :Result do
    abstract
    
    attribute :SampleRate, 'The rate the waveform was sampled at, default back to the value given in the data item', 0..1
    attribute :ResetTriggered, 'An optional indicator that the event or sample was reset', 0..1, :DataItemResetValue
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
    member :Duration, 'The number of seconds since the reset of the statistic', 0..1, :DurationTime
  end
  
  Glossary.samples.each do |sample|
    type(sample.keys['elementname'].to_sym, sample.keys['description'], :Sample) do
      if sample.keys['units'] =~ /3d$/
        member :Value, "the value for #{sample.keys['elementname']}", :ThreeDimensionalValue
      else
        member :Value, "the value for #{sample.keys['elementname']}", :FloatValue
      end
    end
  end
  
  type :AbsTimeSeries, 'The abstract waveform', :Sample do
    abstract
    
    attribute :SampleCount, 'The number of samples', :CountValue
  end
  
  type :TimeSeries, 'An abstract time series with the restriction value', :AbsTimeSeries do
    abstract
    
    member :Value, 'The time series representation', :TimeSeriesValue
  end

  # Create waveforms for all the samples:
  self.elements.each do |type|
    if type.parent == :Sample and type.name != :PathPosition
      self.type "#{type.name}TimeSeries".to_sym, "Time series of #{type.annotation}", :TimeSeries
    end
  end
  
end
