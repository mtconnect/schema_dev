self.urn = 'urn:example.com:ExampleStreams:1.2'
self.namespace = 'e'
self.top = :MTConnectStreams
self.license = File.read('../license.txt')
self.version = '1.2'

import "../MTConnectStreams", '../MTConnectStreams_1.2.xsd'

package :Example, 'Example Package' do
  float = '[+-]?\d+(\.\d+)?(E[+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  
  basic_type(:SignalStrengthValue, 'The strength of the signal in db') { pattern float_value }
  basic_type(:CommonVariableValue, 'The value') { pattern float_value }
  attr :Index, 'The index into the common variables table', :integer
  
  type :SignalStrength, 'The pressure', :Sample do
    member :Value, 'The flow', :SignalStrengthValue
  end
  
  type :AbstractCommonVariable2, 'An abstract common variable', :Event do
    abstract
    member :Index, 'the values index'
  end    
  
  type :CommonVariable2, 'A variable value', :AbstractCommonVariable2 do
    member :Value, 'the value', :CommonVariableValue
  end

  type :CommonVariable, 'A variable value', :Event do
    member :Value, 'the value', :CommonVariableValue
  end
end


