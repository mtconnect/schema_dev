
self.urn = 'urn:mtconnect.org:MTConnectStreams:1.6'
self.namespace = 'mt'
self.top = :MTConnectStreams
self.license = File.read('license.txt')
self.version = '1.7'

load 'common'

package :MTC, 'MTC Top Level Package' do
  attr :Station, 'The station id for this device'
  
  type :Header, 'Message header for protocol information' do
    member :Version, 'The document version'
    member :CreationTime, 'The date and time the document was created'
    member :NextSequence, 'The next sequence number for subsequent requests', 1, :Sequence
    member :LastSequence, 'The last sequence number available from the agent', 1, :Sequence
    member :FirstSequence, 'The first sequence number available from the agent', 1, :Sequence
    member :TestIndicator, 'Indicates that this was a test document', 0..1
    member :InstanceId, 'The unique instance identifier of this agent process'
    member :Sender, 'The sender of the message'
    member :BufferSize, 'The size of the agent\'s buffer.'
  end
  
  type :MTConnectStreams, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Streams, 'Streams of data for each piece of equipment'
  end
end

load 'streams'
load 'samples'
load 'events'
load 'data_set'
load 'table'
load 'condition'
load 'alarm'
load 'interface_stream'


