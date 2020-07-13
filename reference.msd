package :References, 'References between entities' do

  type :References, 'A list of references' do
    member :Reference, 'A reference to another part of the model', 1..INF
  end
  
  type :Reference, 'An abstract reference type' do
    abstract
    member :IdRef, 'A reference to an id in the MTConnectDevices model'
    member :Name, 'An optional name of the referenced item, used for documentation', 0..1
  end
  
  type :DataItemRef, 'A data item reference', :Reference
  type :ComponentRef, 'A data item reference', :Reference
  
end
