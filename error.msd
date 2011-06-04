
package :Error, 'The error package' do
  basic_type :ErrorDescription, 'The text description of the error'
  enum :ErrorCode, 'The error code' do
    value :UNAUTHORIZED, 'The request did not have sufficient permissions to perform the request.'
    value :NO_DEVICE, 'The device specified in the URI could not be found.'
    value :OUT_OF_RANGE, 'The sequence number was beyond the end of the buffer.'
    value :TOO_MANY, 'The count given is too large.'
    value :INVALID_URI, 'The URI provided was incorrect.'
    value :INVALID_REQUEST, 'The request was not one of the three specified requests.'
    value :INTERNAL_ERROR, 'Contact the software provider, the agent did not behave correctly.'
    value :INVALID_PATH, 'The xpath could not be parsed. Invalid syntax.'
    value :UNSUPPORTED, 'The request is not supported by this implementation'
    value :ASSET_NOT_FOUND, 'The asset ID cannot be found'
  end

  type :Error, 'An error description' do
    member :ErrorCode, 'The error code'
    member :Value, 'The description', :ErrorDescription
  end
  
end
