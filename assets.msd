
package :Assets, 'Mobile Assets' do
  attr :Source, 'A URI reference', :anyURI
  attr :Removed, 'A flag indicating the item has been removed', :boolean
  
  type :AssetDescription, 'The description of an asset, can be freeform text or elemenrts' do
    mixed
    member :any, 'Any elements', 0..INF
  end  
  
  type :Assets, 'The collection of mobile assets' do
    choice(0..INF) do
      member :Asset, 'A tool assembly'
    end
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :AssetId, 'The unique identifier of the asset'
    member :Timestamp, 'The time asset information was recorded'
    member :DeviceUuid, 'The uuid this tool is associated with', 0..1, :Uuid
    member :Removed, 'The asset has been marked as removed', 0..1
  end    
end