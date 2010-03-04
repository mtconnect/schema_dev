
package :Systems, 'The systems package' do
  
  type :System, 'A logical group of Axes representing a structural base', :CommonComponent
  
  type :Pneumatic, 'A component representing the pneumatic system', :System
  type :Hydrolic, 'A component representing the hydrolic system', :System
  type :Lubrication, 'A component representing the lubrication system', :System
  type :Coolant, 'A component representing the coolant system', :System
end
