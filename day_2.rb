class IntcodeProcessor
  ADD_OPTCODE = 1
  MULT_OPTCODE = 2
  HALT_OPTCODE = 99

  def initialize(intcode, noun, verb)
    @intcode = intcode
    @noun = noun
    @verb = verb
  end

  def call
    restore_gravity_assist_program
    process_intcode

    @intcode
  end

  private

  attr_accessor :position

  def restore_gravity_assist_program
    @intcode[1] = @noun
    @intcode[2] = @verb
  end

  def process_intcode
    @position = 0

    while @intcode[@position] != HALT_OPTCODE
      case @intcode[@position]
      when ADD_OPTCODE
        handle_add
      when MULT_OPTCODE
        handle_mult
      end

      iterate
    end
  end

  def iterate
    @position += 4
  end

  def handle_add
    @intcode[@intcode[@position + 3]] =
      @intcode[@intcode[@position + 1]] + @intcode[@intcode[@position + 2]]
  end

  def handle_mult
    @intcode[@intcode[@position + 3]] =
      @intcode[@intcode[@position + 1]] * @intcode[@intcode[@position + 2]]
  end
end

input = File.read('day_2_input.txt').chomp.split(',').map(&:to_i)

# p IntcodeProcessor.new([1,0,0,0,99]).call == [2,0,0,0,99]
# p IntcodeProcessor.new([2,3,0,3,99]).call == [2,3,0,6,99]
# p IntcodeProcessor.new([2,4,4,5,99,0]).call == [2,4,4,5,99,9801]
# p IntcodeProcessor.new([1,1,1,4,99,5,6,0,99]).call == [30,1,1,4,2,5,6,0,99]

# Part 2
(0..99).each do |noun|
  (0..99).each do |verb|
    result = IntcodeProcessor.new(input.dup, noun, verb).call
    if result[0] == 19690720
      p 100 * noun + verb
      exit
    end
  end
end
