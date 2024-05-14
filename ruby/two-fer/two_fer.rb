TwoFer = 'One for %<name>s, one for me.'

module TwoFerable
  def two_fer(name = 'you')
    self % {name:}
  end
end

TwoFer.extend(TwoFerable)

# manual testing
if __FILE__ == $PROGRAM_NAME
  p TwoFer.two_fer([1, 2, 'Jim'])
  p TwoFer.two_fer(false)
  p TwoFer.two_fer(nil)
  p TwoFer.two_fer
end

