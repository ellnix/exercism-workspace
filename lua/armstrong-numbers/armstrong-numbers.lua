local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
  local n_str = tostring(number)
  local sum = 0

  for i = 1, #n_str do
    sum = sum + tonumber(n_str:sub(i, i)) ^ #n_str
  end

  return sum == number
end

return ArmstrongNumbers
