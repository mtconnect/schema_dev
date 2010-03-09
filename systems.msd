
package :Systems, 'The systems package' do
  
  type :Systems, 'A grouping of all the systems of the device', :CommonComponent
  type :System, 'A logical group of parts representing sub-system of the device', :CommonComponent
  
  type :Pneumatic, 'A component representing the pneumatic system', :System
  type :Hydraulic, 'A component representing the hydraulic system', :System
  type :Lubrication, 'A component representing the lubrication system', :System
  type :Coolant, 'A component representing the coolant system', :System
end
