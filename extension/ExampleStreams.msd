self.urn = 'urn:example.com:ExampleStreams:1.1'
self.namespace = 'e'
self.top = :MTConnectStreams
self.license = File.read('../license.txt')
self.version = '1.1'

import "../MTConnectStreams", 'http://www.mtconnect.org/schemas/MTConnectStreams_1.1.xsd'

package :Example, 'Example Package' do
  float = '[+-]?\d+(\.\d+)?(E[+-]?\d+)?'
  float_value = "#{float}|UNAVAILABLE"
  
  basic_type(:FlowValue, 'The flow') { pattern float_value }
  
  type :Flow, 'The pressure', :Sample do
    member :Value, 'The flow', :FlowValue
  end
end


