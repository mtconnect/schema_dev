
package :qif, 'QIF Assets' do
  type :InspectionArchetype, 'An inspection plan', :Asset do
    member :any, 'Any elements', 1
  end
  type :Inspection, 'An inspection result', :Asset do
    member :any, 'Any elements', 1
  end
end
