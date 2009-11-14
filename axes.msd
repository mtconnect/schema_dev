package :Axes, 'The axes package' do  
  enum :orientation, "Orientation of an axis" do
    value :HORIZONTAL, 'Horizontal'
    value :VERTICAL, 'Vertical'
  end
  
  type :Axes, 'A logical group of Axes representing a structural base', :CommonComponent
  
  type :Axis, 'A abstract machine axis', :CommonComponent do
    abstract
    standards :OPC => 'Channel', :OMAC => 'axis'
    member :orientation, 'The orientation of this axis', 0..1
  end

  type :Linear, 'A linear axis', :Axis
  type :Rotary, 'A rotary axis that moves in a rotational manor', :Axis
  type :Spindle, 'DEPRECATED: A spindle axis that spins', :Axis
end
