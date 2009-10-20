package :Axes, 'The axes package' do
  type :Axes, 'The machines axes. There are currently four types of axes available', :CommonComponent

  type :Axis, 'A abstract machine axis', :CommonComponent do
    abstract
    standards :OPC => 'Channel', :OMAC => 'axis'
  end

  type :Linear, 'A linear axis', :Axis
  type :Rotary, 'A rotary axis that moves in a rotational manor', :Axis
  type :Spindle, 'A spindle axis that spins', :Axis
end
