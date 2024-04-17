=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end

module Luhn
  def self.valid?(input)
    input.gsub! ' ', ''

    return false if input.size < 2 || input =~ /[^\d]/

    sum = input.chars.reverse.each_slice(2).sum { |(a, b)| a.to_i + luhn_double(b.to_i) }
    (sum % 10).zero?
  end

  def self.luhn_double(n)
    n * 2 > 9 ? n * 2 - 9 : n * 2
  end
end
