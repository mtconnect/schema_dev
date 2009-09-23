
self.urn = 'urn:mtconnect.com:MTConnectError:1.0'
self.namespace = 'mt'
self.top = :MTConnectError

load 'common'

package :MTConnectError, 'MTC Top Level Package' do
  type :MTConnectError, 'The root node for MTConnect' do
    member :Header, 'Protocol dependent information'
    member :Error, 'An error result'
  end
end

load 'error'


