
package :Alarms, 'Alarms Package, these are types of events' do
  basic_type :AlarmDescription, 'The description of the alarm'
  attr :NativeAlarmCode, 'An alarm code as defined by the component'
  enum :AlarmCode, 'Types of alarms' do
    value :FAILURE, 'A failure'
    value :FAULT, 'A fault occurred'
    value :CRASH, 'A spindle crash'
    value :JAM, 'A component has jammed'
    value :OVERLOAD, 'The component has been overloaded'
    value :ESTOP, 'E-Stop was pushed'
    value :MATERIAL, 'A material failure has occurred'
    value :MESSAGE, 'An operators message. Used with INFO severity'
    value :OTHER, 'Another alarm type'
    # Need to complete this list
  end
  enum :AlarmState, 'The state of the alarm' do
    value :ACTIVE, 'The alarm has occurred' do
      standards :IPC => 'Alarm'
    end
    value :CLEARED, 'The alarm has been reset' do
      standards :IPC => 'CLEARED'
    end
    value :INSTANT, 'The alarm is a instant message and clears immediately'
  end
  enum :Severity, 'The alarms severity' do
    value :CRITICAL, 'A critical alarm has occurred' do
      standards :IPC => 'Alarm'
    end
    value :ERROR, 'An error has occurred' do
      standards :IPC => 'Error'
    end
    value :WARNING, 'A warning' do
      standards :IPC => 'Warning'
    end
    value :INFO, 'Just informational'
  end
  
  type :Alarm, 'An alarm event', :Event do
    standards :OPC => 'AlarmMessage', :IPC => 'Alarm, Error, or Warning'
    
    member :Code, 'The alarm type', :AlarmCode do
      standards :PackML => 'Reason Code', :OMAC => 'Alarm.Number'
    end
    member :Severity, 'The severity' do
      standards :OPC => 'Severity', :IPC => 'Encoded in the message'
    end
    member :NativeCode, 'The component specific alarm code', :NativeAlarmCode
    member :State, 'The alarm\'s state', :AlarmState
    member :Value, 'The alarm\'s description', :AlarmDescription
  end  
end
