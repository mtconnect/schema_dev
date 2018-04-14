
package :Systems, 'The systems package' do
  
  type :Systems, 'A grouping of all the systems of the device', :CommonComponent
  type :System, 'A logical group of parts representing sub-system of the device', :CommonComponent
  
  type :Pneumatic, 'A component representing the pneumatic system', :System
  type :Hydraulic, 'A component representing the hydraulic system', :System
  type :Lubrication, 'A component representing the lubrication system', :System
  type :Coolant, 'A component representing the coolant system', :System
  type :Electric, 'A component representing the electrical system', :System

  # Version 1.4
  type :Enclosure, 'Represents the structure used to contain or isolate a piece of equipment or an area.', :System
  type :Protective, 'A system that detect or prevent harm or damage to equipment or personnel', :System
  type :ProcessPower, 'A power source associated with a piece of equipment that supplies energy to the manufacturing process separate from the Electric system', :System
  type :Feeder, 'A system that manages the delivery of materials within a piece of equipment', :System
  type :Dielectric,'A chemical mixture used in a manufacturing process being performed at that piece of equipment', :System
end
