defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread {}, %Character { health: hp } = character) do
      {nil, %Character { character | health: hp + 5 }}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion { strength: mana }, %Character { mana: mp } = character) do 
      { %EmptyBottle {}, %Character { character | mana: mp + mana } }
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison {}, character), do: { %EmptyBottle {}, %{ character | health: 0 } }
  end
end
