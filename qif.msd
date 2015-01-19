
package :qif, 'QIF Assets' do
  type :InspectionPlan, 'An inspection plan', :Asset do
    member :any, 'Any elements', 1
  end
  type :InspectionResult, 'An inspection result', :Asset do
    member :any, 'Any elements', 1
  end
end
