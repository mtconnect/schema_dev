
package :Structure, 'The structural components of a machine' do
  type :Structure, 'A component to organize the structural components of the machine', :CommonComponent

  type :Table, 'A structural component representing the table on which material can be placed', :Structure

  type :Link, 'A connection between two Rotary or Linear axes (Joints)', :Structure

  type :SolidModel, 'The axis motion types', :AbstractConfiguration do
    mixed
    attribute :'href', 'Reference to the file', :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
    member :Scale, 'A three space scaler', 0..1, :ThreeSpaceValue
    member :Transformation, 'A rotation and translation', 0..1
  end  
end
