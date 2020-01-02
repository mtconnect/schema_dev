
package :Samlpes, 'The samples' do
  float = '[+-]?\d+(\.\d+)?([Ee][+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  vector_value = "(#{float}( )*)+|UNAVAILABLE"
  
  basic_type :SampleValue, 'An floating point value or array of floating point values'
  basic_type(:PositionValue, 'The value for the position') { pattern float_value }
  basic_type(:EnergyValue, 'The value of energy') {  pattern float_value }
  basic_type(:DecibelValue, 'The sound pressure') {  pattern float_value }
  basic_type(:DisplacementValue, 'The value for the displacement') { pattern float_value }
  basic_type(:FrequencyValue, 'The value for the frequency') { pattern float_value }
  basic_type(:AmperageValue, 'The amperage') { pattern float_value }
  basic_type(:VoltageValue, 'The voltage') { pattern float_value }
  basic_type(:WattValue, 'The watts') { pattern float_value }
  basic_type(:PressureValue, 'The pressure') { pattern float_value }
  basic_type(:AccelerationValue, 'The value for the acceleration') { pattern float_value }
  basic_type(:AngleValue, 'The angle') { pattern float_value }
  basic_type(:TemperatureValue, 'The temperature') { pattern float_value }
  basic_type(:VelocityValue, 'The temperature') { pattern float_value }
  basic_type(:FeedrateValue, 'The feedrate') { pattern float_value }
  basic_type(:VibrationValue, 'The vibration') { pattern float_value }
  basic_type(:RotationalVelocityValue, 'The spindle speed') { pattern float_value }
  basic_type(:LoadValue, 'A component load') { pattern float_value }
  basic_type(:TorqueValue, 'A component\'s torque') { pattern float_value }
  basic_type(:ThreeDimensionalValue, 'A three dimensional value \'X Y Z\' or \'A B C\'') { pattern "#{float} #{float} #{float}|UNAVAILABLE" }
  basic_type(:TiltValue, 'The value for the position') { pattern float_value }
  basic_type(:PowerFactorValue, 'Power factor') { pattern float_value }
  basic_type(:StrainValue, 'Strain') { pattern float_value }
  basic_type(:FlowValue, 'Flow') { pattern float_value }
  basic_type(:SoundPressureValue, 'Sound pressure level') { pattern float_value }
  basic_type(:ResistanceValue, 'Electrical resistance') { pattern float_value }
  basic_type(:ConductivityValue, 'Conductivity') { pattern float_value }
  basic_type(:ViscosityValue, 'Viscosity') { pattern float_value }
  basic_type(:ConcentrationValue, 'Concentration') { pattern float_value }
  basic_type(:TimeSeriesValue, 'A time series') { pattern vector_value }
  basic_type(:DurationValue, 'The duration of an event in seconds') { pattern float_value }
  basic_type(:CountValue, 'The number of values') { pattern float_value }
  basic_type(:ForceValue, 'The magnitude of push or pull') { pattern float_value }
  basic_type(:MassValue, 'The weight of an object') { pattern float_value }
  basic_type(:FillLevelValue, 'The fill level of a tank') { pattern float_value }
  basic_type(:SampleRate, 'The sampling rate in samples per second') { pattern float_value }
  basic_type(:LengthValue, 'The length in millimeters') { pattern float_value }
  basic_type(:ClockTime, 'The length in millimeters') { pattern float_value }
  
  attr :DurationTime, 'A length of time in seconds', :float
  
  type :Sample, 'An abstract sample', :Result do
    abstract
    
    attribute :SampleRate, 'The rate the waveform was sampled at, default back to the value given in the data item', 0..1
    attribute :ResetTriggered, 'An optional indicator that the event or sample was reset', 0..1, :DataItemResetValue
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
    member :Duration, 'The number of seconds since the reset of the statistic', 0..1, :DurationTime
  end
  
  type :Amperage, 'An current a component is drawing', :Sample do
    member :Value, 'amperage', :AmperageValue
  end

  type :GlobalPosition, 'DEPRECATED: The three space position of the component', :Sample do
    member :Value, 'The position', :ThreeDimensionalValue
  end

  type :Position, 'The position of the component', :Sample do
    member :Value, 'The position', :PositionValue
  end

  type :Velocity, 'The velocity of the component', :Sample do
    member :Value, 'The velocity', :VelocityValue
  end

  type :Acceleration, 'The acceleration of the component', :Sample do
    member :Value, 'The Acceleration', :AccelerationValue
  end
  
  type :AngularAcceleration, 'The angular acceleration of the component', :Sample do
    member :Value, 'The Acceleration', :AccelerationValue
  end
  
  type :AngularVelocity, 'The angular velocity of the component', :Sample do
    member :Value, 'The velocity', :VelocityValue
  end

  type :PathFeedrate, 'The feedrate of the component', :Sample do
    member :Value, 'The feedrate', :FeedrateValue
  end

  type :AxisFeedrate, 'The feedrate of the component', :Sample do
    member :Value, 'The feedrate', :FeedrateValue
  end

  type :SpindleSpeed, 'The spindle speed of the component: DEPRECATED', :Sample do
    member :Value, 'The spindle speed', :RotationalVelocityValue
  end
  
  type :RotaryVelocity, 'The rotational velocity of the component in RPM', :Sample do
    member :Value, 'The velocity', :VelocityValue
  end

  type :Angle, 'The angle of the component', :Sample do
    member :Value, 'The angle', :AngleValue
  end

  type :Temperature, 'The temperature', :Sample do
    member :Value, 'Temperature', :TemperatureValue
  end

  type :Load, 'The program code', :Sample do
    member :Value, 'The load on the component', :LoadValue
  end

  type :Frequency, 'The frequency in hertz', :Sample do
    member :Value, 'The frequency in hertz', :FrequencyValue
  end
  
  type :Volts, 'DEPRECATED: The voltage', :Sample do
    member :Value, 'The voltage', :VoltageValue
  end

  type :Voltage, 'The voltage', :Sample do
    member :Value, 'The voltage', :VoltageValue
  end
  
  type :Watt, 'DEPRECATED: The number of Watts', :Sample do
    member :Value, 'The Watts', :WattValue
  end
    
  type :Pressure, 'The pressure', :Sample do
    member :Value, 'The pressure', :PressureValue
  end

  type :Torque, 'The torque', :Sample do
    member :Value, 'The torque', :TorqueValue
  end
  
  type :PathPosition, 'The 3 dimensional position for tool tip in the path (X Y Z)', :Sample do
    member :Value, 'The position', :ThreeDimensionalValue
  end
  
  # For 1.2
  type :Wattage, 'The number of Watts', :Sample do
    member :Value, 'The Watts', :WattValue
  end
  
  type :Displacement, 'The linear displacement in millimeters', :Sample do
    member :Value, 'The displacement as measured from zero to peak', :DisplacementValue
  end
   
  type :Tilt, 'The tilt', :Sample do
    member :Value, 'The tilt', :TiltValue
  end
  
  type :AccumulatedTime, 'The non-contiguous duration of an event in seconds', :Sample do
    member :Value, 'The duration', :DurationValue
  end
  
  type :PowerFactor, 'The power factor', :Sample do
    member :Value, 'Power factor', :PowerFactorValue
  end

  type :Strain, 'The strain', :Sample do
    member :Value, 'strain', :StrainValue
  end

  type :Flow, 'The flow', :Sample do
    member :Value, 'flow', :FlowValue
  end

  type :SoundPressure, 'The sound pressure', :Sample do
    member :Value, 'sound pressure', :SoundPressureValue
  end
  
  type :Resistance, 'The Resistance', :Sample do
    member :Value, 'Resistance', :ResistanceValue
  end
  
  type :Conductivity, 'The Conductivity', :Sample do
    member :Value, 'Conductivity', :ConductivityValue
  end

  type :Viscosity, 'The Viscosity', :Sample do
    member :Value, 'Viscosity', :ViscosityValue
  end
  
  type :Concentration, 'The Concentration', :Sample do
    member :Value, 'Concentration', :ConcentrationValue
  end

  type :ElectricalEnergy, 'Electrical energy', :Sample do
    member :Value, 'Energy in watt seconds', :EnergyValue
  end
  
  type :FillLevel, 'The fill level of a tank', :Sample do
    member :Value, 'The fill level', :FillLevelValue
  end

  type :LinearForce, 'The magnitude of a push or pull introduced by an actuator or exerted on an object', :Sample do
    member :Value, 'Force value', :ForceValue
  end

    type :SoundLevel, 'Measurement of a sound level or sound pressure level relative to atmospheric pressure' do
      member :Value, 'Decibel value', :DecibelValue
    end
  
  type :Length, 'The length of an object', :Sample do
    member :Value, 'Length', :LengthValue
  end

  type :EquipmentTimer, 'The flow', :Sample do
    member :Value, 'flow', :FlowValue
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
    if type.parent == :Sample
      self.type "#{type.name}TimeSeries".to_sym, "Time series of #{type.annotation}", :TimeSeries
    end
  end
  
end
