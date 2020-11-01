package :DataSet, 'Table Package' do
  type :TableCell, 'A cell of a table' do
    mixed
    abstract
    ordered
    member :Key, 'the key'
  end

  type :TableEntry, 'An entry for a table', :Entry do
    mixed
    ordered
    member :Cell, 'The table\'s cell', 0..INF, :TableCell
  end

  # Create data set events for non-state events
  %w{WorkOffset ToolOffset}.each do |s| 
    type = self.schema.type(s.to_sym)
    vm = type.value_member
    cell_type = if vm and vm.type
                   vm.type
                 else
                   :StringEventValue
                 end

    self.type "#{type.name}TableEntry".to_sym, "Table Entry of #{type.annotation}", :Entry do
      mixed
      ordered
      member :Cell, "Cells for #{type.name} table", 0..INF, "#{type.name}Cell".to_sym
    end
    
    self.type "#{type.name}Cell".to_sym, "Cell of #{type.annotation}", :TableCell do
      ordered
      member :Value, "Entry for #{type.name} table", cell_type
    end
    
    self.type "#{type.name}Table".to_sym, "Table of #{type.annotation}", :Event do
      mixed
      ordered
      attribute :Count, 'The number of entries', :CountValue
      member :Entry, 'The entries', 0..INF, "#{type.name}TableEntry".to_sym
    end
  end
end
