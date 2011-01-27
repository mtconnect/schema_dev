
package :Samlpes, 'The samples' do
  float = '[+-]?\d+(\.\d+)?(E[+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  
  basic_type :SampleValue, 'An events data'
  basic_type(:PositionValue, 'The value for the position') { pattern float_value }
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
  basic_type(:SpindleSpeedValue, 'The spindle speed') { pattern float_value }
  basic_type(:LoadValue, 'A component load') { pattern float_value }
  basic_type(:TorqueValue, 'A component\'s torque') { pattern float_value }
  basic_type(:ThreeDimensionalValue, 'A three dimensional value \'X Y Z\' or \'A B C\'') { pattern "#{float} #{float} #{float}|UNAVAILABLE" }
  
  type :Sample, 'An abstract sample', :Result do
    abstract
    
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
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
    member :Value, 'The spindle speed', :SpindleSpeedValue
  end
  
  type :RotationalVelocity, 'The rotational velocity of the component in RPM', :Sample do
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

  type :Displacement, 'The displacement as measured from zero to peak', :Sample do
    member :Value, 'The displacement as measured from zero to peak', :DisplacementValue
  end
  
  type :Frequency, 'The frequency in hertz', :Sample do
    member :Value, 'The frequency in hertz', :FrequencyValue
  end
  
  type :Voltage, 'The voltage', :Sample do
    member :Value, 'The voltage', :VoltageValue
  end
  
  type :Watts, 'The number of Watts', :Sample do
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
  
end
