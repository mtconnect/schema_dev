
# coding: utf-8

package :DataSet, 'DataSet Package' do
  
  type :Entry, 'An entry for a event with a data set representation' do
    mixed
    abstract
    member :Key, 'the key'
    member :Removed, 'an indicatore that the entry has been removed', 0..1
  end

  # Create data set events for non-state events
  %w{Variable}.each do |s| 
    type = self.schema.type(s.to_sym)
    vm = type.value_member
    entry_type = if vm and vm.type
                   vm.type
                 else
                   :StringEventValue
                 end

    self.type "#{type.name}Entry".to_sym, "DataSet of #{type.annotation}", :Entry do
      member :Value, "Entry for #{type.name} data set", entry_type
    end
    
    self.type "#{type.name}DataSet".to_sym, "DataSet of #{type.annotation}", :Event do
      mixed
      attribute :Count, 'The number of entries', :CountValue
      member :Entry, 'The entries', 0..INF, "#{type.name}Entry".to_sym
    end
  end
end


