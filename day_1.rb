# https://adventofcode.com/2019/day/1

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
    fuel = (mass / 3).floor - 2
    (fuel <= 0) ? 0 : (fuel + fuel_for_mass(fuel))
  end
end

p FuelCalculator.new([1969]).call == 966
p FuelCalculator.new([100756]).call == 50346

modules_mass = File.open('day_1_input.txt').readlines.map(&:chomp).map(&:to_i)
p FuelCalculator.new(modules_mass).call
