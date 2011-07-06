self.urn = 'urn:example.com:ExampleStreams:1.2'
self.namespace = 'e'
self.top = :MTConnectStreams
self.license = File.read('../license.txt')
self.version = '1.2'

import "../MTConnectStreams", '/schemas/MTConnectStreams_1.2.xsd'

package :Example, 'Example Package' do
  float = '[+-]?\d+(\.\d+)?(E[+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  
  basic_type(:SignalStrengthValue, 'The strength of the signal in db') { pattern float_value }
  
  type :SignalStrength, 'The pressure', :Sample do
    member :Value, 'The flow', :SignalStrengthValue
  end
end


