return function(array, target)
  local lower = 1
  local upper = #array

  while upper >= lower do
    local midpoint = (upper - lower) // 2 + lower
    local elem = array[midpoint]

    if elem == target then
      return midpoint
    elseif elem < target then
      lower = midpoint + 1
    elseif elem > target then
      upper = midpoint - 1
    end
  end

  return -1
end
