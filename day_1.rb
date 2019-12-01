class FuelCalculator
  attr_reader :modules_mass

  def initialize(modules_mass)
    @modules_mass = modules_mass
  end

  def call
    total_fuel
  end

  private

  def total_fuel
    modules_mass.inject(0) { |total, mass| total + fuel_for_mass(mass) }
  end

  def fuel_for_mass(mass)
    # Fuel required to launch a given module is based on its mass.
    # Specifically, to find the fuel required for a module,
    # - take its mass,
    # - divide by three,
    # - round down,
    # - and subtract 2.
    (mass / 3).floor - 2
  end
end

p FuelCalculator.new([12, 14, 1969, 100756]).call == [2, 2, 654, 33583].reduce(:+)

modules_mass = File.open('day_1_input.txt').readlines.map(&:chomp).map(&:to_i)
p FuelCalculator.new(modules_mass).call
