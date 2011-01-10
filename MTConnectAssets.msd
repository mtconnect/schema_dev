
self.urn = 'urn:mtconnect.org:MTConnectAssets:1.2'
self.namespace = 'mt'
self.top = :MTConnectAssets
self.license = File.read('license.txt')
self.version = '1.2'

load 'common'

package :MTC, 'MTC Top Level Package' do
  type :Header, 'Message header for protocol information' do
    member :Version, 'The document version'
    member :CreationTime, 'The date and time the document was created'
    member :TestIndicator, 'Indicates that this was a test document', 0..1
    member :InstanceId, 'The unique instance identifier of this agent process'
    member :Sender, 'The sender of the message'
    member :BufferSize, 'The size of the agent\'s buffer.'
  end

  type :MTConnectAssets, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Assets, 'The assets'
  end
end

load 'assets.msd'
