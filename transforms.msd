package :Transforms, 'Transforms for coordinates or dimensions' do
  
  type :Transformations, 'A set of named transformations associated with a device', :AssetInstance do
    member :Transformation, 'A named transformation', 1..INF
  end

  basic_type :OffsetValue, 'An offset given in millimeters or degrees', :float
  
  type :Offset, 'An floating point represention of a transformation' do
    member :Name, 'The name of the transformation', 0..1    
    member :Value, 'The value', :OffsetValue
  end
  
  type :Transformation, 'A named transformation' do
    member :Name, 'The name of the transformation'
    
    member :X, 'The X linear offset in millimeters', 0..1, :Offset
    member :Y, 'The Y linear offset in millimeters', 0..1, :Offset
    member :Z, 'The Z linear offset in millimeters', 0..1, :Offset
    member :Length, 'A length linear offset in millimeters', 0..1, :Offset
    member :Diameter, 'A diameter linear offset in millimeters', 0..1, :Offset
    
    member :A, 'The A angular offset in degrees (rotation around X)', 0..1, :Offset
    member :B, 'The B angular offset in degrees (rotation around Y)', 0..1, :Offset
    member :C, 'The C angular offset in degrees (rotation around Z)', 0..1, :Offset
  end
end
