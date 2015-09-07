xsimport 'xlink', 'http://www.w3.org/1999/xlink', 'http://www.w3.org/1999/xlink.xsd'

# coding: utf-8
package :Files, 'Files or Documents' do
  
  attr :VersionId, 'The version of the file'
  attr :FileMimeType, 'The mime type of the file'
  attr :FileSize, 'The size in bytes of the file', :integer
  attr :FileName, 'The name of the file'
  attr :FileApplicationType, 'The application of this file. Maybe we should use an enum?'
  
  # Archetype
  type :FileArchetype, 'Common information regarding a file', :AssetArchetype do
    member :Name, 'The file name', :FileName
    member :Type, 'The mime type of the file', :FileMimeType
    member :ApplicationType, 'The classification of this file', 0..1, :FileApplicationType
    member :FileProperties, 'A set of file properties', 0..1
  end
  
  # Common
  type :FileProperties, 'A set of associated properties' do
    member :FileProperty, 'A file property', 1..INF
  end
  
  basic_type :FilePropertyValue, 'The value of a file property'
  type :FileProperty, 'A property of a file' do
    member :Name, 'The name of the property', :Name
    member :Value, 'Property value', :FilePropertyValue
  end
  
  # File Instance
  enum :FileState, 'File state' do
    value :EXPERIMENTAL, 'exp file'
    value :PRODUCTION, 'production file'
  end
  
  basic_type :FileComment, 'The log entry'
  type :File, 'The file version info', :AssetInstance do
    member :Size, 'The size in bytes', :FileSize
    member :VersionId, 'The version identifier'
    member :Name, 'The file name', :FileName
    member :State, 'The file state', 0..1, :FileState
    member :Location, 'The file location', :FileLocation
    member :Signature, 'The file\'s signature'  
    member :FileProperties, 'A set of file properties', 0..1
  end
  
  type :FileLocation, 'XLink to file location' do
    attribute :'xlink:href', 'Reference to the file', :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end
  
end