

package :Auxiliaries, 'The Auxiliaries package' do
  
  type :Auxiliaries, 'A grouping of functional sub-systems that provide supplementary or extended capabilities for a piece of equipment', :CommonComponent
  type :Auxiliary, 'A functional sub-systems that provide supplementary or extended capabilities for a piece of equipment, , but they are not required for the basic operation of the equipment', :CommonComponent
  
  type :Loader, 'unit comprised of all the parts involved in moving and distributing materials, parts, and other items to or from a piece of equipment', :Auxiliary
  type :WasteDisposal, 'unit comprised of all the parts involved in removing manufacturing byproducts from a piece of equipment', :Auxiliary
  type :ToolingDelivery, 'unit involved in managing, positioning, storing, and delivering tooling within a piece of equipment', :Auxiliary
  type :BarFeeder, 'a unit involved in delivering bar stock to a piece of equipment.', :Auxiliary
  type :Environmental, 'unit or function involved in monitoring, managing, or conditioning the environment around or within a piece of equipment', :Auxiliary
  type :Sensor, 'A sensor, this is not abstract to allow for easy extensibility.', :Auxiliary  
end
