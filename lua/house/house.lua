local house = {}

local intros = {
  'This is the house that Jack built',
  'This is the malt',
  'This is the rat',
  'This is the cat',
  'This is the dog',
  'This is the cow with the crumpled horn',
  'This is the maiden all forlorn',
  'This is the man all tattered and torn',
  'This is the priest all shaven and shorn',
  'This is the rooster that crowed in the morn',
  'This is the farmer sowing his corn',
  'This is the horse and the hound and the horn'
}

local actions = {
  'that belonged to the farmer sowing his corn',
  'that kept the rooster that crowed in the morn',
  'that woke the priest all shaven and shorn',
  'that married the man all tattered and torn',
  'that kissed the maiden all forlorn',
  'that milked the cow with the crumpled horn',
  'that tossed the dog',
  'that worried the cat',
  'that killed the rat',
  'that ate the malt',
  'that lay in the house that Jack built'
}

house.verse = function(which)
  local verse = intros[which]

  for i = 1, which - 1 do
    verse = verse .. "\n" .. actions[#actions - which + i + 1]
  end

  return verse .. "."
end

house.recite = function()
  local rhyme = ""
  
  for i = 1, #actions + 1 do
    rhyme = rhyme .. house.verse(i) .. "\n"
  end

  return rhyme:sub(0, #rhyme - 1)
end

return house
