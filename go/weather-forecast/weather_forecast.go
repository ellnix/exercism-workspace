// Package weather provides functions for reporting weather events.
package weather

// CurrentCondition stores the condition in the forecast.
var CurrentCondition string
// CurrentLocation stores the location of the forecast.
var CurrentLocation string

// Forecast takes a city and a weather condition and formats then in a string.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
