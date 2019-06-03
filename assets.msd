package :Assets, 'Mobile Assets' do
  attr :Source, 'A URI reference', :anyURI
  
  type :AssetDescription, 'The description of an asset, can be free form text or elements' do
    mixed
    member :any, 'Any elements', 0..INF
  end  
  
  type :Assets, 'The collection of mobile assets' do
    choice(0..INF) do
      member :Asset, 'An asset'
    end
  end
  
  type :Asset, 'An abstract mobile asset' do
    abstract
    member :AssetId, 'The unique identifier of the asset'
    member :Timestamp, 'The time asset information was recorded'
    member :DeviceUuid, 'The uuid this tool is associated with', :Uuid
    member :Removed, 'The asset has been marked as removed', 0..1
  end
end
