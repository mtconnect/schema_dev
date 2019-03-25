
package :Condition, 'The condition of the device' do
  basic_type :ConditionDescription, 'The description of the Condition'
  attr :NativeSeverity, 'The device\'s severity'
  enum :Qualifier, 'A qualifier for the condition' do
    # Conditions
    value :HIGH, 'The value is too high'
    value :LOW, 'The value is too low'
  end
  
  type :Condition, 'An abstract indicator of the device\'s condition' do
    abstract
    
    member :Observation, 'Common attributes'
    member :type, 'The type of condition', :DataItemEnum
    member :NativeCode, 'The component specific Notifcation code', 0..1
    member :NativeSeverity, 'The component specific Notifcation code', 0..1
    member :Qualifier, 'An optional attribute that helps qualify the condition', 0..1
    member :Statistic, 'The statistical operation on this data', 0..1, :DataItemStatistics
    member :Value, 'The description of the condition', :ConditionDescription
  end
  
  type :Unavailable, 'The conditon can not be determined.', :Condition
  type :Normal, 'The item being monitored is operating normally and no action is required. Also indicates a cleared condition.', :Condition
  type :Warning, 'he item being monitored is moving into the abnormal range and should be observed. No action required at this time.', :Condition
  type :Fault, 'The item has failed an intervention is required to return to a normal condition. Transition to a normal condition indicates that the Fault has been cleared. Something that needs to be acknowledged. Sometimes noted as an alarm.', :Condition
end
