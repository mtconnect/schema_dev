
package :Capabilities, 'Capabilities of components' do
  enum :CapabilityEnum, 'Capabilities for a component' do
    value :ROTARY_MODE, 'The mode for the rotary axis'
  end
  
  enum :CapabilityOption, 'The values of the capability' do
    value :INDEX, 'Indexing - moving to an angle'
    value :SPIN, 'Spining at a given velocity/spindle speed'
    value :CONTOUR, 'Indexing and Spinning at a given velocity'
  end
  
  type :CapabilityValue, 'A possible value for the capability' do 
    member :Value, 'The optional capability value', :CapabilityOption
  end
  
  type :Capability, 'A components capability' do
    member :Type, 'The type of capability', :CapabilityEnum
    member :Value, 'A value for this capability', :CapabilityValue, 1..INF 
  end
end