
package :Condition, 'The condition of the device' do
  basic_type :ConditionDescription, 'The description of the Condition'
  enum :ConditionSubType, 'The condition\'s sub-classification ' do
    
  end
  
  type :Condition, 'An abstract indicator of the device\'s condition', :Result do
    abstract
    member :type, 'The type of condition', :DataItemEnum
    member :NativeCode, 'The component specific Notifcation code', 0..1
    member :Value, 'The description of the condition', :ConditionDescription
  end
  
  type :Normal, 'The item being monitored is operating normally and no action is required. Also indicates a cleared condition.', :Condition
  type :Warning, 'he item being monitored is moving into the abnormal range and should be observed. No action required at this time.', :Condition
  type :Fault, 'The item has failed an intervention is required to return to a normal condition. Transition to a normal condition indicates that the Fault has been cleared. Something that needs to be acknowledged. Sometimes noted as an alarm.', :Condition
end