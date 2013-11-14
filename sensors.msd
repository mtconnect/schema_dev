package :Sensors, 'Sensor Calibration inspired by TEDS 1451.4' do
  basic_type :CalibrationDate, 'The time the calibration was preformed',:date
  basic_type :NextCalibrationDate, 'The time the next calibration should be preformed',:date
  basic_type :CalibrationInitials, 'The initials of the person doing the calibration', :string
  basic_type :FirmwareVersion, 'The firmware version of this sensor', :string
  
  attr :ChannelNumber, 'The channel number', :integer
  
  type :SensorConfiguration, 'Calibration data for a sensor', :AbstractConfiguration do
    member :FirmwareVersion, 'The firmware version'
    member :CalibrationDate, 'The date and time the sensor was calibrated', 0..1
    member :NextCalibrationDate, 'The date and time the sensor was calibrated', 0..1
    member :CalibrationInitials, 'The initials of the person who calibrated this sensor', 0..1
    member :any, 'Any additional properties', 0..INF do
      self.notNamespace = "##targetNamespace"
      self.processContents = 'strict'
    end
    
    member :Channels, 'The sensor channels', 0..1
  end
    
  type :Channels, 'A collection of channel calibration data' do
    member :Channel, 'A calabration channel', 1..INF
  end
  
  type :Channel, 'The calibration channel' do
    member :Number, 'The channel id', :ChannelNumber
    member :Name, 'The channel name', 0..1
    member :Description, 'A text description of the channel', 0..1, :DescriptionText
    
    member :CalibrationDate, 'The date and time the sensor was calibrated', 0..1
    member :NextCalibrationDate, 'The date and time the sensor was calibrated', 0..1
    member :CalibrationInitials, 'The initials of the person who calibrated this sensor', 0..1
  end
end
