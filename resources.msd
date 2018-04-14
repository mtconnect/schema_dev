

package :Resources, 'The Resources package' do
  
  type :Resources, 'groups items that support the operation of a piece of equipment', :CommonComponent
  type :Resource, 'An item that supports the operation of a piece of equipment', :CommonComponent
  
  type :Materials, 'materials or other items consumed or used by the piece of equipment for production of parts, materials, or other types of goods', :Resource
  type :Stock, 'material that is used in a manufacturing process and to which work is applied in a machine or piece of equipment to produce parts', :Resource
  type :Personnel, 'provides information about an individual or individuals who either control, support, or otherwise interface with a piece of equipment', :Resource
end
