
package :Inspection, 'Inspection, Measurement, and Quality' do
  attr :InspectionStandard, 'The inspection standard'
  
  
  type :InspectionArchetype, 'Inspection Asset containing QIF or other standards for inspection plan', :AssetArchetype do
    member :InspectionStandard, 'The standard being used for the inspection content', 0..1
    member :any, 'Any elements', 0..INF
  end

  type :Inspection, 'Inspection Asset containing QIF or other standards for inspection results', :AssetInstance do
    member :InspectionStandard, 'The standard being used for the inspection content', 0..1
    member :any, 'Any elements', 0..INF    
  end
end