require 'set'

class OrbitsCounter
  def initialize(input)
    @orbits = {}
    @uncounted_objects = Set.new
    @input = input
  end

  def call
    prepare_data

    # Part 1
    # count_orbits

    # Part 2
    shortest_path_to('YOU', 'SAN')
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

  # Part 2
  def shortest_path_to(obj1, obj2)
    obj1_path = path_to_root_with_costs(obj1)
    obj2_path = path_to_root_with_costs(obj2)
    common_parents = obj1_path.keys & obj2_path.keys

    common_parents.map do |parent|
      [parent, obj1_path[parent] + obj2_path[parent]]
    end.min { |parent| parent[1] }
  end

  def path_to_root_with_costs(object)
    [].tap do |path|
      cost = 0
      current_object = orbits[object]

      while orbits[current_object]
        path << [current_object, cost]

        cost += 1
        current_object = orbits[current_object]
      end
    end.to_h
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
K)YOU
I)SAN
HEREDOC

# p OrbitsCounter.new(test_input).call == 42
p OrbitsCounter.new(test_input).call == 4

input = File.open('day_6_input.txt').read
p OrbitsCounter.new(input).call
