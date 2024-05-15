package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
  return map[string]int{
    "quarter_of_a_dozen": 3,
    "half_of_a_dozen": 6,
    "dozen": 12,
    "small_gross": 120,
    "gross": 144,
    "great_gross": 1728,
  }
}

// NewBill creates a new bill.
func NewBill() map[string]int {
  return map[string]int {}
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
  val, exists := units[unit]

  if exists {
    bill[item] += val
  }

  return exists
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
  itemCount, itemExists := bill[item]
  unitVal, unitExists := units[unit]

  if itemExists && unitExists {
    if itemCount > unitVal {
      bill[item] -= unitVal
    } else if itemCount == unitVal  {
      delete(bill, item)
    } else {
      return false
    }

    return true
  }

  return false
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (itemCount int, exists bool) {
  itemCount, exists = bill[item]
  return
}
