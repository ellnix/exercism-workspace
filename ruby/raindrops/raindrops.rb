=begin
Write your code for the 'Raindrops' exercise in this file. Make the tests in
`raindrops_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/raindrops` directory.
=end

class Raindrops
  def self.convert(n)
    output = ''

    output += 'Pling' if n % 3 == 0
    output += 'Plang' if n % 5 == 0
    output += 'Plong' if n % 7 == 0

    output == '' ? n.to_s : output
  end
end
