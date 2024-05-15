package lasagna

func PreparationTime(layers []string, timePerLayer int) int {
  if timePerLayer == 0 {
    timePerLayer = 2
  }

  return timePerLayer * len(layers)
}

func Quantities(layers []string) (noodles int, sauce float64) {
  for _, layer := range layers {
    if layer == "noodles" {
      noodles += 50
    } else if layer == "sauce" {
      sauce += 0.2
    }
  }

  return
}

func AddSecretIngredient(friendRecipe, myRecipe [] string) {
  myRecipe[len(myRecipe) - 1] = friendRecipe[len(friendRecipe) - 1]
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
  portioned := make([]float64, len(quantities))

  for i, two_portions := range quantities {
    portioned[i] = two_portions / 2.0 * float64(portions)
  }

  return portioned
}
