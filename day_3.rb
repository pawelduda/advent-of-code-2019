class WiresIntersectionDistance
  STARTING_POINT = [0, 0].freeze

  def initialize(wire1, wire2)
    @wires_data = [wire1, wire2]
    @wires_paths = [[STARTING_POINT], [STARTING_POINT]]
  end

  def call
    generate_paths
    intersections = (@wires_paths[0][1..-1] & @wires_paths[1]) # Ignore the starting point
    intersections.map { |coords| distance_from_start(coords) }.min
  end

  private

  def generate_paths
    (0..1).each do |wire_num|
      generate_path(wire_num)
    end
  end

  def generate_path(wire_num)
    @wires_data[wire_num].each do |move|
      process_move(move, wire_num)
    end
  end

  def process_move(move, wire_num)
    current_coords = @wires_paths[wire_num][-1]

    direction = move[0]
    distance = move[1..-1].to_i

    distance.times do
      case direction
      when 'D'
        new_coords = [current_coords[0] - 1, current_coords[1]]
      when 'L'
        new_coords = [current_coords[0], current_coords[1] - 1]
      when 'U'
        new_coords = [current_coords[0] + 1, current_coords[1]]
      when 'R'
        new_coords = [current_coords[0], current_coords[1] + 1]
      end

      @wires_paths[wire_num] << new_coords
      current_coords = new_coords
    end
  end

  def distance_from_start(coords)
    coords.map(&:abs).reduce(:+)
  end
end

wires_data = File.open('day_3_input.txt').readlines.map(&:chomp)
                 .map { |line| line.split(',') }

p WiresIntersectionDistance.new(wires_data[0], wires_data[1]).call

