
package :Capabilities, 'Capabilities of components' do
  enum :CapabilityEnum, 'Capabilities for a component' do
    value :ROTARY_FUNCTION, 'Rotary functions'
  end
  
  enum :CapabilityValue, 'The values of the capability' do
    value :INDEX, 'Indexing - moving to an angle'
    value :SPIN, 'Spining at a given velocity/spindle speed'
    value :CONTOUR, 'Indexing and Spinning at a given velocity'
  end
  
  type :Capability, 'A components capability' do
    member :type, 'The type of capability', :CapabilityEnum
    member :Value, 'The capability', :CapabilityValue
  end
end