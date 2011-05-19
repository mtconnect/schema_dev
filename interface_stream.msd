
package :InterfaceStream, 'A stream of interfaces' do
  
  enum :InterfaceState, 'Interface state' do
    value :READY, 'The interface is in an idle state'
    value :ACTIVE, 'The interface is executing an activity'
    value :COMPLETE, 'The executor is finished with the activity'
  end
  
  type :Interface, 'An abstract interface events', :Result do
    abstract
    
    member :State, 'The state of the interface', :InterfaceState
  end
  
  type :FeedStock, 'A request/response for feeding of material', :Interface
  type :ChangeStock, 'A request/response to change the material', :Interface
end