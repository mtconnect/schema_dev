self.urn = 'urn:example.com:ExampleDevices:1.2'
self.namespace = 'e'
self.top = :MTConnectDevices
self.license = File.read('../license.txt')
self.version = '1.2'

import "../MTConnectDevices", 'http://www.mtconnect.org/schemas/MTConnectDevices_1.2.xsd'

package :Example, 'Example Package' do
  type :Pump, 'A pump.', :CommonComponent
end


