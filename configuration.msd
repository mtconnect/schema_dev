package :Configuration, 'The component\'s configuration' do
    type :AbstractConfiguration, 'Abstract configuration' do
    abstract
  end
  
  type :ComponentConfiguration, 'The configuration data associated with this component.' do
    mixed
    
    member :Configuration,  'Configuration types', 1..INF, :AbstractConfiguration
  end   
end

load 'sensors'
load 'specifications'
load 'relationships'
load 'coordinate_systems'
load 'motion'
load 'solid_model'
