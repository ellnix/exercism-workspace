local EliudsEggs = {}

local function to_binary_string(number)
  local binary = ''

  while number > 0 do
    binary = tostring(number % 2) .. binary
    number = number // 2
  end

  return binary
end

function EliudsEggs.egg_count(number)
  local binary_string = to_binary_string(number)

  local egg_count = 0

  for i = 1, #binary_string do
    local spot = binary_string:sub(i, i)
    if spot == '1' then
      egg_count = egg_count + 1
    end
  end

  return egg_count
end

return EliudsEggs
