
self.urn = 'urn:mtconnect.com:MTConnectDevices:1.0'
self.namespace = 'mt'
self.top = :MTConnectDevices

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

  type :MTConnectDevices, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Devices, 'The equipment'
  end
end

load 'components'
load 'axes'
load 'data_items'


