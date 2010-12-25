self.urn = 'urn:example.com:ExampleDevices:1.1'
self.namespace = 'e'
self.top = :MTConnectDevices
self.license = File.read('../license.txt')
self.version = '1.1'

import "../MTConnectDevices", 'http://www.mtconnect.org/schemas/MTConnectDevices_1.1.xsd'

package :Example, 'Example Package' do
  type :Pump, 'A pump.', :CommonComponent
end


