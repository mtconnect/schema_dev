# coding: utf-8


package :common, 'Common attributes and elements for all schemas' do
  attr :Sender, 'The sender of the message'
  attr :CreationTime, 'The date and time the document was created', :dateTime
  attr(:Sequence, 'A sequence number', :integer) do
    facet 'minIncl=1;maxExcl=18446744073709551615'
  end
  attr :TestIndicator, 'A debugging flag for testing.', :boolean
  attr(:InstanceId, 'The instance number of the agent, used for fault tolerance', :integer) do
    facet 'minIncl=1;maxExcl=18446744073709551615'
  end
  attr(:BufferSize, 'The size of the agents buffer', :integer) do 
    facet 'minIncl=1;maxExcl=4294967295'
  end
  
  attr :Timestamp, 'The time the sample was reported', :dateTime
  attr :OccurrenceTime, 'The time a sample occurred', :dateTime
  attr :Version, 'A version number', :NMTOKEN
  attr :Name, 'A short name for any element'
  attr :Uuid, 'A universally unique id that uniquely identifies the element for it\'s entire life'
  attr :SerialNumberAttr, 'A serial number for a piece of equipment'
  attr :ItemSource, 'The measurement source'
  attr :Rate, 'A sample rate in milliseconds per sample', :float
  attr :ComponentId, 'The id of the component (maps to the id from probe)', :ID
  attr :ID, 'An identifier', :ID
  attr :SignificantDigitsValue, 'The number significant digits', :integer
  attr :CompositionId, 'The item\'s reference to the Device model composition', :NMTOKEN
  attr :DurationTime, 'A length of time in seconds', :float
  attr :Removed, 'A flag indicating the item has been removed', :boolean
  
  attr :AssetId, 'The unique id of the asset'
  attr :AssetAttrType, 'An asset type'
  attr(:AssetBufferSize, 'The maximum number of assets', :integer) do
    facet 'minIncl=1;maxExcl=4294967295'
  end
  attr(:AssetCountAttr, 'The number of assets', :integer) do
    facet 'minIncl=0;maxExcl=4294967295'    
  end

  basic_type(:FloatListValue, 'Common floating point sample value') {
    list(:float)
  }
  basic_type(:ThreeSpaceValue, 'A three dimensional value \'X Y Z\' or \'A B C\'', :FloatListValue) {
    facet('max=3;min=3')
  }

  basic_type :DescriptionText, 'A description'
  basic_type(:DataItemExt, 'An extension point for data item types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  basic_type(:DataItemStatsExt, 'An extension point for data item statistics types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  enum :DataItemEnum, 'The types of measurements available' do
    extensible :DataItemExt

    Glossary.types.each do |e|
      value(e.name_property, e.description)
    end

    value :VARIABLE, 'A user variable'
  end

  enum :DataItemSubEnum, 'The sub-types for a measurement' do
    extensible :DataItemExt

    uniq = Set.new
    Glossary.subtypes.each do |e|
      if !uniq.include?(e.name_property)
        value(e.name_property, e.description)
        uniq << e.name_property
      end
    end
  end
  
  enum :DataItemStatistics, 'Statistical operations on data' do
    extensible :DataItemStatsExt

    Glossary.statistics.each do |e|
      value(e.name_property, e.description)
    end
  end
  
  # Common Units
  basic_type(:UnitsExt, 'An extension point for data item types') do
    pattern 'x:[A-Z_0-9]+'
  end

  enum :Units, 'The units supported' do
    extensible :UnitsExt

    Glossary.units.each do |e|
      value(e.name_property, e.description)
    end
  end

  enum :NativeUnits, 'The units supported for the source equipment that can be converted into MTC Units.', :Units do
    # Alternate types for the source system.
    extensible :UnitsExt

    Glossary.nativeUnits.each do |e|
      value(e.name_property, e.description)
    end
  end
  
  enum :CoordinateSystemEnum, 'The coordinate system to be used for the position' do
    Glossary.coordinateSystems.each do |e|
      value(e.name_property, e.description)
    end
  end
  
  basic_type(:DataItemResetValueExt, 'An extension point for reset types') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  
  enum :DataItemResetValue, 'The reset intervals' do
    extensible :DataItemResetValueExt

    Glossary.resetTriggers.each do |e|
      value(e.name_property, e.description)
    end
  end
  
end
