
self.urn = 'urn:mtconnect.org:MTConnectStreams:1.6'
self.namespace = 'mt'
self.top = :MTConnectStreams
self.license = File.read('license.txt')
self.version = '1.7'

load 'common'

package :MTC, 'MTC Top Level Package' do
  attr :Station, 'The station id for this device'
  
  type :Header, 'Message header for protocol information' do
    member :HeaderAttributes, 'Common Attributes'
    
    member :BufferSize, 'The size of the agent\'s buffer.'    
    member :NextSequence, 'The next sequence number for subsequent requests', 1, :Sequence
    member :LastSequence, 'The last sequence number available from the agent', 1, :Sequence
    member :FirstSequence, 'The first sequence number available from the agent', 1, :Sequence
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


