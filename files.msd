xsimport 'xlink', 'http://www.w3.org/1999/xlink', 'http://www.w3.org/1999/xlink.xsd'

# coding: utf-8
package :Files, 'Files or Documents' do
  
  attr :VersionId, 'The version of the file'
  attr :FileMimeType, 'The mime type of the file'
  attr :FileSize, 'The size in bytes of the file', :integer
  attr :FileName, 'The name of the file'
  
  type :File, 'Common information regarding a file', :Asset do
    member :VersionId, 'The current version', 0..1
    member :Type, 'The mime type of the file', :FileMimeType
    member :Size, 'The size in bytes', :FileSize
    member :Name, 'The file name', :FileName
    member :Description, 'The description of the file (freeform)', 0..1, :AssetDescription
    member :Location, 'The file location', :FileLocation
    member :Signature, 'The file\'s signature'  
    member :Versions, 'The file version information', 0..1, :FileVersions
  end
  
  type :FileVersions, 'File version information' do
    member :Version, 'Version info', 1..INF, :FileVersion
  end
  
  basic_type :FileComment, 'The log entry'
  type :FileVersion, 'The file version info' do
    member :VersionId, 'The version identifier'
    member :Timestamp, 'The version timestamp'
    member :Location, 'The file location', :FileLocation
    member :Comment, 'The file comment', 0..1, :FileComment
  end
  
  type :FileLocation, 'XLink to file location' do
    attribute :'xlink:href', 'Reference to the file', :'xlink:href'
    attribute(:'xlink:type', 'Type of href', :'xlink:type') { self.fixed = 'locator' }
  end
  
end