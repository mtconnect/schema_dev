
self.urn = 'urn:mtconnect.org:MTConnectDevices:1.6'
self.namespace = 'mt'
self.top = :MTConnectDevices
self.license = File.read('license.txt')
self.version = '1.7'

xsimport "xlink", 'http://www.w3.org/1999/xlink', 'xlink.xsd'

load 'common'

package :MTC, 'MTC Top Level Package' do
  basic_type(:AssetCountValue, 'The number of assets', :integer) do
    facet 'minIncl=0;maxExcl=4294967295'    
  end
  
  type :AssetCounts, 'The number of assets by type' do
    member :AssetCount, 'The number of assets for a given type', 1..INF
  end
    
  type :AssetCount, 'The count of assets for a certain type' do
    member :AssetType, 'The type of asset', :AssetAttrType
    member :Value, 'The count', :AssetCountValue
  end
  
  type :Header, 'Message header for protocol information' do
    member :HeaderAttributes, 'Common Attributes'
    
    member :BufferSize, 'The size of the agent\'s buffer.'    
    member :AssetBufferSize, 'The maximum number of assets'
    member :AssetCount, 'The number of assets we have', :AssetCountAttr
    member :AssetCounts, 'The asset statistics', 0..1
  end

  type :MTConnectDevices, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Devices, 'The equipment'
  end
end

load 'components'
load 'data_items'

