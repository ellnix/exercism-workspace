# 00001 = wink
# 00010 = double blink
# 00100 = close your eyes
# 01000 = jump
# 10000 = Reverse the order of the operations in the secret handshake.

class SecretHandshake
  COMMANDS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  def initialize(number)
    @binary = number.to_i.to_s(2).reverse[0..4]
  end

  def commands
    cmds = COMMANDS.zip(@binary.chars).filter_map { |cmd, bin| cmd if bin == '1' }
    cmds.reverse! if @binary[4] == '1'

    cmds
  end
end
