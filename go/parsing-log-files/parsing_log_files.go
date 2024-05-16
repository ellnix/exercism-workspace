package parsinglogfiles

import (
	"fmt"
	"regexp"
)

// [TRC]
// [DBG]
// [INF]
// [WRN]
// [ERR]
// [FTL]

func IsValidLine(text string) bool {
  re := regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
  return re.MatchString(text)
}

func SplitLogLine(text string) []string {
  re := regexp.MustCompile(`<[-=*~]*>`)
  return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) (occurrences int) {
  re := regexp.MustCompile(`(?i)".*password.*"`)
  for _, line := range lines {
    if re.MatchString(line) { occurrences++ }
  }

  return
}

func RemoveEndOfLineText(text string) string {
  re := regexp.MustCompile(`end-of-line\d*`)
  return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
  re := regexp.MustCompile(`User\s+(\w+)`)
  for i, line := range lines {
    user := re.FindStringSubmatch(line)

    if user != nil {
      lines[i] = fmt.Sprintf("[USR] %s %s", user[1], line)
    }
  }

  return lines
}
