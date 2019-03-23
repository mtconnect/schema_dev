self.urn = 'urn:mtconnect.org:B2MML:1.5'
self.namespace = 'b'
self.top = :MTConnectAssets
self.license = File.read('../license.txt')
self.version = '1.5'

import "../MTConnectAssets", 'MTConnectAssets_1.5.xsd'

package :Example, 'B2MML Package' do
  type :PartArchetype, 'A part or group of individual parts that are being from workpieces', :AssetArchetype do
  end
end


