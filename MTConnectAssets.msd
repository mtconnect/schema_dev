
self.urn = 'urn:mtconnect.org:MTConnectAssets:1.6'
self.namespace = 'mt'
self.top = :MTConnectAssets
self.license = File.read('license.txt')
self.version = '1.7'
self.urn = "urn:mtconnect.org:MTConnectAssets:#{self.version}"

xsimport "xlink", 'http://www.w3.org/1999/xlink', 'xlink.xsd'


load 'common'

package :MTConnectAsset, 'MTC Top Level Package' do  
  type :Header, 'Message header for protocol information' do
    member :HeaderAttributes, 'Common Attributes'

    member :AssetBufferSize, 'The maximum number of assets'
    member :AssetCount, 'The number of assets we have', :AssetCountAttr
  end

  type :MTConnectAssets, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Assets, 'The assets'
  end
end

load 'assets.msd'
load 'data_items.msd'
load 'streams.msd'
load 'events.msd'
load 'samples.msd'
load 'condition.msd'
load 'tools.msd'
load 'files.msd'

# Deferred to 1.6
#load 'process.msd'
#load 'parts.msd'
#load 'inspection.msd'
