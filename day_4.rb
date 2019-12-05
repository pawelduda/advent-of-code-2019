class PasswordCombinationsCounter
  attr_reader :range

  def initialize(range)
    @range = range
  end

  def call
    password_combinations_count
  end

  private

  def password_combinations_count
    range.inject(0) do |count, password|
      pw_digits = password.to_s.split('').map(&:to_i)

      if two_adjacent_equal_digits?(pw_digits) && digits_dont_decrease?(pw_digits)
        count + 1
      else
        count
      end
    end
  end

  def two_adjacent_equal_digits?(password)
    (0..4).detect do |position|
      password[position] == password[position + 1]
    end
  end

  def digits_dont_decrease?(password)
    (1..5).all? do |position|
      password[position - 1] <= password[position]
    end
  end
end

p PasswordCombinationsCounter.new(356261..846303).call
