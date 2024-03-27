# | File type | Common extension | Media type                   | binary 'signature'                               |
# | --------- | ---------------- | ---------------------------- | ------------------------------------------------ |
# | ELF       | `"exe"`          | `"application/octet-stream"` | `0x7F, 0x45, 0x4C, 0x46`                         |
# | BMP       | `"bmp"`          | `"image/bmp"`                | `0x42, 0x4D`                                     |
# | PNG       | `"png"`          | `"image/png"`                | `0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A` |
# | JPG       | `"jpg"`          | `"image/jpg"`                | `0xFF, 0xD8, 0xFF`                               |
# | GIF       | `"gif"`          | `"image/gif"`                | `0x47, 0x49, 0x46`                               |

defmodule FileSniffer do
  @extensions %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif",
  }

  def type_from_extension(extension) do
    @extensions[extension]
  end

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "application/octet-stream"
      <<0x42, 0x4D, _::binary>> -> "image/bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "image/png"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "image/jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "image/gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    if type_from_binary(file_binary) == type_from_extension(extension) && type_from_extension(extension) do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
