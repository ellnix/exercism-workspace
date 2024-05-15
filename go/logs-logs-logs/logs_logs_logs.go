package logs

import "unicode/utf8"

// Application identifies the application emitting the given log.
func Application(log string) string {
  for _, rune := range log {
    switch rune {
    case '❗': return "recommendation"
    case '🔍': return "search"
    case '☀': return "weather"
    }
  }

  return "default"
}

// Replace replaces all occurrences of old with new, returning the modified log
// to the caller.
func Replace(log string, oldRune, newRune rune) string {
  runes := make([]rune, utf8.RuneCountInString(log))
  i := 0

  for _, rune := range log {
    switch rune{
    case oldRune: runes[i] = newRune
    default: runes[i] = rune
    }

    i++
  }

  return string(runes)
}

// WithinLimit determines whether or not the number of characters in log is
// within the limit.
func WithinLimit(log string, limit int) bool {
  return limit >= utf8.RuneCountInString(log)
}
