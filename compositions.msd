package :Compositions, 'The compositions for the device model' do

  type :Compositions, "A collection of sub elements" do
    member :Composition, 'An assembly of a component', 1..INF
  end

  basic_type(:CompositionTypeExt, 'An extension point for Composition') do
    pattern '[a-ln-z]:[A-Z_0-9]+'
  end
  enum :CompositionEnumType, 'The vocab for the type of composition' do
    extensible :CompositionTypeExt
    value :ACTUATOR, 'A mechanism for moving or controlling a mechanical part of a piece of equipment'
    value :AMPLIFIER, 'An electronic component or circuit for amplifying power, current, or voltage'
    value :BALLSCREW, 'A mechanical structure for transforming rotary motion into linear motion'
    value :BATTERY, 'A storage device that stores and produces electrical engergy'
    value :BELT, 'An endless flexible band used to transmit motion for a piece of equipment or to convey materials and objects'
    value :BRAKE, 'A mechanism for slowing or stopping a moving object'
    value :CIRCUIT_BREAKER, 'A mechanism for interrupting an electric circuit'
    value :CHAIN, 'An interconnected series of objects that band together and used to transmit motion for a piece of equipment or to convey materials and objects.'
    value :CHOPPER, 'A mechanism used to break material into smaller pieces.'
    value :CHUCK, 'A mechanism that holds a part, stock material, or any other item in place'
    value :CHUTE, 'An inclined channel for conveying material'
    value :CLAMP, 'A mechanism used to strengthen, support, or fasten objects in place'
    value :COMPRESSON, 'A pump or other mechanism for reducing volume and increasing pressure of gases in order to condense the gases  to drive pneumatically powered pieces of equipment'
    value :DOOR, 'Amechanical mechanism or closure that can cover an access portal into a piece of equipment.'
    value :DRAIN, 'A mechanism that allows material to flow for the purpose of drainage from, for example, a vessel or tank.'
    value :ENCODER, 'A mechanism used to measure rotary position.'
    value :FAN, 'Any device for producing a current of air'
    value :FILTER, 'Any substance or structure through which liquids or gases are passed to remove suspended impurities or to recover solids.'
    value :GRIPPER, 'A mechanism that holds a part, stock material, or any other item in place'
    value :HOPPER, 'A chamber or bin in which materials are stored temporarily, being filled through the top and dispensed through the bottom.'
    value :LINEAR_POSITION_FEEDBACK, 'A mechanism that measures motion or position'
    value :MOTOR, 'A mechanism that converts electrical, pneumatic, or hydraulic energy into mechanical energy'
    value :OIL, 'A viscous liquid'
    value :PUMP, 'An apparatus raising, driving, exhausting, or compressing fluids or gases by means of a piston, plunger, or set of rotating vanes.'
    value :POWER_SUPPLY, 'A device that provides power to electric mechanisms'
    value :PULLY, 'A mechanism or wheel that turns in a frame or block and serves to change the direction of or to transmit force'
    value :SENSING_ELEMENT, ' A mechanism that provides a signal or measured value'
    value :STORAGE_BATTERY, 'A component consisting of one or more cells, in which chemical energy is converted into electricity and used as a source of power'
    value :SWITCH, 'A mechanism for turning on or off an electric current or for making or breaking a circuit'
    value :TANK, 'A receptacle or container for holding material'
    value :TENSIONER, 'A mechanism that provides or applies a stretch or strain to another mechanism.'    
    value :TRANSFORMER, 'A mechanism through which transforms electric energy from a source to a secondary circuit'
    value :VALVE, 'Any mechanism for halting or controlling the flow of a liquid, gas, or other material through a passage, pipe, inlet, or outlet,'
    value :WATER, 'H2O'
    value :WIRE, 'A string like piece or filament of relatively rigid or flexible material provided in a variety of diameters.'
  end
                                                                         
  

  type :Composition, "An abstract element" do
    member :id, 'The data item identifier', :ID
    member :Uuid, 'The composition\'s universally unique id.', 0..1
    member :Name, 'The data item identifier', 0..1
    member :Type, 'The type of composition', :CompositionEnumType
    member :Description, 'The descriptive information about this sub element', 0..1, :ComponentDescription
  end  
end
