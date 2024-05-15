return function(scores)
  local hs = {}
  hs.scores = scores

  hs.scores =  function()
    return scores
  end

  hs.latest = function()
    return scores[#scores]
  end

  hs.personal_best = function()
    local max = 0

    for i = 1, #scores do
      if scores[i] > max then
        max = scores[i]
      end
    end

    return max
  end

  hs.personal_top_three = function()
    local sorted = {}
    for i = 1, #scores do
      sorted[i] = scores[i]
    end
    table.sort(sorted)
    return { sorted[#sorted], sorted[#sorted - 1], sorted[#sorted - 2] }
  end

  return hs
end
