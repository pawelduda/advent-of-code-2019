require 'set'

class OrbitsCounter
  def initialize(input)
    @orbits = {}
    @uncounted_objects = Set.new
    @input = input
  end

  def call
    prepare_data
    count_orbits
  end

  private

  attr_reader :input, :orbits, :uncounted_objects

  def prepare_data
    input.each_line do |line|
      parent, child = line.chomp.split(')')

      if @orbits[child]
        @orbits[child] << parent
      else
        @orbits[child] = parent
      end

      @uncounted_objects << parent
      @uncounted_objects << child
    end
  end

  def count_orbits
    count = 0

    uncounted_objects.each do |object|
      while orbits[object]
        object = orbits[object]
        count += 1
      end
    end

    count
  end
end

test_input = <<HEREDOC
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
HEREDOC

p OrbitsCounter.new(test_input).call == 42

input = File.open('day_6_input.txt').read
p OrbitsCounter.new(input).call
