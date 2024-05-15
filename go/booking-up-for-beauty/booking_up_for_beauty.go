package booking

import (
	"fmt"
	"time"
)

// Mon Jan 2 15:04:05 -0700 MST 2006
// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
  time, _ := time.Parse("1/2/2006 15:04:05", date)

  return time
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
  date_time, _ := time.Parse("January 2, 2006 15:04:05", date)
  return date_time.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
  date_time, _ := time.Parse("Monday, January 2, 2006 15:04:05", date)
  hour, _, _ := date_time.Clock()

  return hour >= 12 && hour < 18
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
  date_time := Schedule(date)

  return date_time.Format("You have an appointment on Monday, January 2, 2006, at 15:04.")
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
  this_year := time.Now().Year()
  
  date_time, _ := time.Parse("2006-1-2 15:04:05 -0700 MST", fmt.Sprintf("%d-9-15 00:00:00 +0000 UTC", this_year))

  return date_time
}
