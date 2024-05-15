package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(calculator FodderCalculator, cowsCount int) (float64, error) {
  totalFodder, fodderErr := calculator.FodderAmount(cowsCount)

  if fodderErr != nil {
    return 0, fodderErr
  }

  factor, factorErr := calculator.FatteningFactor()

  if factorErr != nil {
    return 0, factorErr
  }

  return totalFodder * factor / float64(cowsCount), nil
}

func ValidateInputAndDivideFood(calculator FodderCalculator, cowsCount int) (float64, error) {
  if cowsCount <= 0 {
    return 0, errors.New("invalid number of cows")
  }

  return DivideFood(calculator, cowsCount)
}

type InvalidCowsError struct {
  cowsCount int
  message string
}

func (err *InvalidCowsError) Error() string {
  return fmt.Sprintf("%d cows are invalid: %s", err.cowsCount, err.message)
}

func ValidateNumberOfCows(cowsCount int) error {
  if cowsCount < 0 {
    return &InvalidCowsError{ cowsCount: cowsCount, message: "there are no negative cows", }
  }

  if cowsCount == 0 {
    return &InvalidCowsError{ cowsCount: cowsCount, message: "no cows don't need food", }
  }

  return nil
}
