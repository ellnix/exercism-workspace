=begin
Write your code for the 'Food Chain' exercise in this file. Make the tests in
`food_chain_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/food-chain` directory.
=end

module FoodChain
  INTROS = {
    'fly' => 'I don\'t know why she swallowed the fly. Perhaps she\'ll die.',
    'spider' => 'It wriggled and jiggled and tickled inside her.',
    'bird' => 'How absurd to swallow a bird!',
    'cat' => 'Imagine that, to swallow a cat!',
    'dog' => 'What a hog, to swallow a dog!',
    'goat' => 'Just opened her throat and swallowed a goat!',
    'cow' => 'I don\'t know how she swallowed a cow!',
    'horse' => 'She\'s dead, of course!'
  }.freeze

  ANIMALS = INTROS.keys.freeze

  class << self 
    def song
      ANIMALS.each.with_index.map do |animal, i|
        chain = middle_animal?(animal) ? "\n#{build_chain(i)}" : ''
        ending = middle_animal?(animal) ? "\n#{INTROS['fly']}" : ''

        "I know an old lady who swallowed a #{animal}.\n" + INTROS[animal] + chain + ending
      end.join("\n\n") + "\n"
    end

    private

    def middle_animal?(animal)
      animal != 'horse' && animal != 'fly'
    end

    def build_chain(len)
      ANIMALS.each_cons(2).take(len).map do |(small, big)|
        small = 'spider that wriggled and jiggled and tickled inside her' if small == 'spider'
        "She swallowed the #{big} to catch the #{small}."
      end.reverse.join("\n")
    end
  end
end

puts FoodChain.song
