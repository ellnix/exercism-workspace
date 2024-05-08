class Raindrops

  def self.convert(n)
    output = ''
    output << 'Pling' if (n % 3).empty?
    output << 'Plang' if (n % 5).empty?
    output << 'Plong' if (n % 7).empty?

    output == '' ? n.to_s : output
  end

end
