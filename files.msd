
# coding: utf-8
package :Files, 'Files or Documents' do
  
  attr :VersionId, 'The version of the file'
  attr :FileMimeType, 'The mime type of the file'
  attr :FileSize, 'The size in bytes of the file', :integer
  attr :FileName, 'The name of the file'
  
  enum :ApplicationCategory, 'The category of application that will use this file' do
    extensible
    value :ASSEMBLY, 'Files regarding the fully assembled product'
    value :DEVICE, 'Device related files'
    value :HANDLING, 'Files relating to the handling of material'
    value :MAINTENANCE, 'File relating to equipment maintenance'
    value :PART, 'Files relating to a part'
    value :PROCESS, 'Files related to the manufacturing process'
    value :INSPECTION, 'Files related to the quality inspection'
    value :SETUP, 'Files related to the setup of a process'
  end
  
  enum :ApplicationType, 'The type classification of a file' do
    extensible
    value :DESIGN, 'Computer aided design files or drawings'
    value :DATA, 'Generic data'
    value :DOCUMENTATION, 'Documentation regarding a category of file'
    value :INSTRUCTIONS, 'User instructions regarding the execution of a task'
    value :LOG, 'The data related to the history of a machine or process'
    value :PRODUCTION_PROGRAM, 'Machine instructions to perform a process'
  end
  
  type :AbstractFile, 'Abstract model that all file types inherit from', :Asset do
    member :Name, 'The file name', :FileName
    member :MediaType, 'The mime type of the file', :FileMimeType
    member :ApplicationCategory, 'The classification of this file'
    member :ApplicationType, 'The sub classification of this file'
    member :FileProperties, 'A set of file properties', 0..1
    member :FileComments, 'The Destination is a reference to the target Device for this File', 0..1
  end
  
  # Archetype
  type :FileArchetype, 'Common information regarding a file', :AbstractFile do
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
    value :EXPERIMENTAL, 'used for processes other than production or otherwise defined.'
    value :PRODUCTION, 'used for production processes'
    value :REVISION, 'the content is modified from PRODUCTION or EXPERIMENTAL (Note: To capture northbound changes. execution -> prod engineering)'
  end  
  
  basic_type :PublicKey, 'An X501 Public Key'
  basic_type :Signature, 'A secure hash'
  basic_type :FileTime, 'A file time', :dateTime
  type :File, 'The file version info', :AbstractFile do
    member :Size, 'The size in bytes', :FileSize
    member :VersionId, 'The version identifier'
    member :State, 'The file state', :FileState
    member :FileLocation, 'The file location'
    member :Signature, 'A secure hash of the file.', 0..1
    member :PublicKey, 'The public key used to verify the signature', 0..1
    member :Destinations, 'The Destination is a reference to the target Device for this File', 0..1, :FileDestinations
    member :CreationTime, 'The time the file was coorected', :FileTime
    member :ModificationTime, 'The time the file was modified', 0..1, :FileTime
  end
  
  type :FileLocation, 'XLink to file location' do
    attribute :'href', 'Reference to the file', :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
  end

  type :FileDestinations, 'Organizes file destinations' do
    member :Destination, 'The Destination is a reference to the target Device for this File', 1..INF, :FileDestination
  end

  type :FileDestination, 'The Destination is a reference to the target Device for this File' do
    member :Value, 'The uuid this tool is associated with', :Uuid
  end

  type :FileComments, 'Organizes file comments' do
    member :FileComment, 'Organizes FileComments entities for Files', 1..INF
  end

  basic_type :CommentText, 'the text of the comment'
  type :FileComment, 'A remark or interpretation for human interpretation associated with a File or FileArchitype.' do
    member :Timestamp, 'The time the comment was made'
    member :Value, 'the text of the comment about the file', :CommentText
  end
end
