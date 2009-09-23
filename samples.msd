
package :Samlpes, 'The samples' do
  basic_type :SampleValue, 'An events data'
  basic_type(:PositionValue, 'The value for the position') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:DisplacementValue, 'The value for the displacement') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:FrequencyValue, 'The value for the frequency') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:AmperageValue, 'The amperage') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:VoltageValue, 'The voltage') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:WattValue, 'The watts') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:PressureValue, 'The pressure') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:AccelerationValue, 'The value for the acceleration') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:AngleValue, 'The angle') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:TemperatureValue, 'The temperature') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:VelocityValue, 'The temperature') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:FeedrateValue, 'The feedrate') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:VibrationValue, 'The vibration') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:SpindleSpeedValue, 'The spindle speed') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:LoadValue, 'A component load') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:TorqueValue, 'A component\'s torque') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  basic_type(:GlobalPositionValue, 'A value given in 3-space as x,y,z') { pattern '[+-]?\d+(\.\d+)?(E[+-]?\d+)?,[+-]?\d+(\.\d+)?(E[+-]?\d+)?,[+-]?\d+(\.\d+)?(E[+-]?\d+)?' }
  
  type :Sample, 'An abstract sample', :Result do
    abstract
  end
  
  type :Amperage, 'An current a component is drawing', :Sample do
    member :Value, 'amperage', :AmperageValue
  end

  type :GlobalPosition, 'The three space position of the component', :Sample do
    member :Value, 'The position', :GlobalPositionValue
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

  type :SpindleSpeed, 'The spindle speed of the component', :Sample do
    member :Value, 'The spindle speed', :SpindleSpeed
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
end
