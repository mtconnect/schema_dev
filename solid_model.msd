package :SolidModel, 'Solid model eternal reference' do

  attr :SolidModelIdRef, 'A reference to another model', :IDREF
  attr :ItemRef, 'A reference to an item in a model'
  
  type :SolidModel, 'A SolidModel is a Configuration that references a file with the three-dimensional geometry of the component or composition. The geometry MAY have a transformation and a scale to position the component with respect to the other components. A geometry file can contain a set of assembled items, in this case, the SolidModel reference the id of the assembly model file and the specific item within that file.', :AbstractConfiguration do
    member :Id, 'the unique identifier for this entity within the MTConnectDevices document', :ID
    member :SolidModelIdRef, 'The associated model file if an item reference is used', 0..1
    attribute :'href', 'Reference to the file', 0..1, :'xlink:href'
    attribute(:'xlink:type', 'Type of href', 0..1, :'xlink:type') { self.fixed = 'locator' }
    member :ItemRef, 'The reference to the item within the model within the related geometry. A modelIdRef MUST be given.', 0..1
    member :MediaType, 'The format of the referenced document', :SolidModelMediaType           
    member :CoordinateSystemIdRef, 'The identifier of the coordinate system that this motion is relative to', 0..1
    member :Transformation, 'A rotation and translation', 0..1
    member :Scale, 'Scaling vector for the model', 0..1, :SolidModelScale
  end


  basic_type(:ScaleValue, 'A three dimensional value \'X Y Z\' or \'A B C\'', :FloatListValue) {
    facet('max=3;min=1')
  }

  type :SolidModelScale, 'The unit vector to scale the model' do
    value 'The unit scale vector', :ScaleValue    
  end

  enum :SolidModelMediaType, 'Solid model media types' do
    extensible
    value :STEP, 'ISO 10303 STEP AP203 or AP242 format'
    value :STL, 'Stereolithography file format'
    value :GDML, 'Geometry Description Markup Language'
    value :OBJ, 'Wavefront OBJ file format'
    value :COLLADA, 'ISO 17506'
    value :IGES, 'Initial Graphics Exchange Specification'
    value :DXF, 'Drawing eXchange Format. Autodesk data interchange format'
    value :'3DS', 'Autodesk file format'
    value :DWG, 'Autodesk file format'
    value :ACIS, 'Dassault file format'
    value :PXT, 'Parasolid XT Siemens data interchange format'
  end
  
end
