
package :Notifications, 'Notifications Package, these are types of events' do
  basic_type :NotifcationDescription, 'The description of the Notifcation'
  attr :NativeNotifcationCode, 'An Notifcation code as defined by the component'
  enum :NotifcationCode, 'Types of Notifcations' do
    value :FAILURE, 'A failure'
    value :FAULT, 'A fault occurred'
    value :CRASH, 'A spindle crash'
    value :JAM, 'A component has jammed'
    value :OVERLOAD, 'The component has been overloaded'
    value :ESTOP, 'E-Stop was pushed'
    value :MATERIAL, 'A material failure has occurred'
    value :MESSAGE, 'An operators message. Used with INFO severity'
    value :OTHER, 'Another Notifcation type'
    # Need to complete this list
  end

  type :Notification, 'An Notifcation event', :Event do
    member :Code, 'The Notifcation type', :NotifcationCode
    #member :Severity, 'The severity'
    member :NativeCode, 'The component specific Notifcation code', :NativeNotifcationCode
    member :Value, 'The Notifcation\'s description', :NotifcationDescription
  end

  type :Error, 'A status message', :Notification
  type :Warning, 'A status message', :Notification
  type :Message, 'A status message', :Notification
end
