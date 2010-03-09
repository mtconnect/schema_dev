
self.urn = 'urn:mtconnect.org:MTConnectMobileAssets:1.2'
self.namespace = 'mt'
self.top = :MTConnectMobileAssets
self.license = File.read('license.txt')
self.version = '1.1'

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

  type :MTConnectMobileAssets, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :MobileAssets, 'The assets'
  end
end

load 'assets.msd'
