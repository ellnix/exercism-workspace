defmodule PaintByNumber do
  defp palette_bit_size(color_count, n) do
    if Math.pow(2, n) < color_count do
      palette_bit_size(color_count, n + 1)
    else
      n
    end
  end

  def palette_bit_size(color_count) do
    # ceil(:math.log2(color_count))
    palette_bit_size(color_count, 0)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    color_size = palette_bit_size(color_count)
    <<first::size(color_size), _rest::bitstring>> = picture

    first
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    color_size = palette_bit_size(color_count)
    <<_first::size(color_size), rest::bitstring>> = picture

    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
