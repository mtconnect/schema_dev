
# coding: utf-8
package :Files, 'Files or Documents' do
  
  attr :VersionId, 'The version of the file'
  attr :FileMimeType, 'The mime type of the file'
  attr :FileSize, 'The size in bytes of the file', :integer
  attr :FileName, 'The name of the file'
  
  basic_type(:ApplicationCategoryExt, 'An extension point for application category') do
    pattern 'x:[A-Z_0-9]+'
  end
  enum :ApplicationCategory, 'The category of application that will use this file' do
    extensible :ApplicationCategoryExt
    value :ASSEMBLY, "Files regarding the fully assembled product"
    value :DEVICE, 'Device related files'
    value :HANDLING, 'Files relating to the handling of material'
    value :MAINTENANCE, 'File relating to equipment maintenance'
    value :PART, 'Files relating to a part'
    value :PROCESS, 'Files related to the manufacturing process'
    value :INSPECTION, 'Files related to the quality inspection'
    value :SETUP, 'Files related to the setup of a process'
  end
  
  basic_type(:ApplicationTypeExt, 'An extension point for application sub-category') do
    pattern 'x:[A-Z_0-9]+'
  end
  enum :ApplicationType, 'The type classification of a file' do
    extensible :ApplicationTypeExt
    value :DESIGN, 'Computer aided design files or drawings'
    value :DATA, 'Generic data'
    value :DOCUMENTATION, 'Documentation regarding for a category of file'
    value :INSTRUCTIONS, 'Instructions regarding the execution of a task'
    value :PROGRAM, 'Machine instructions to perform a process'
  end
  
  
  # Archetype
  type :FileArchetype, 'Common information regarding a file', :AssetArchetype do
    member :Name, 'The file name', :FileName
    member :MediaType, 'The mime type of the file', :FileMimeType
    member :ApplicationCategory, 'The classification of this file'
    member :ApplicationType, 'The sub classification of this file'
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
    member :MediaType, 'The mime type of the file', 0..1, :FileMimeType
    member :ApplicationCategory, 'The classification of this file', 0..1
    member :ApplicationType, 'The sub classification of this file', 0..1
    member :Location, 'The file location', :FileLocation
    member :Signature, 'The file\'s signature'  
    member :FileProperties, 'A set of file properties', 0..1
  end
  
  type :FileLocation, 'XLink to file location' do
    attribute :'href', 'Reference to the file', :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end
  
end
