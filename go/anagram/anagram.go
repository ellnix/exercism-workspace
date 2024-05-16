package anagram

import (
	"slices"
	"strings"
)

func Detect(subject string, candidates []string) (anagrams []string) {
  sorted_subject_runes := []rune(strings.ToLower(subject))
  slices.Sort(sorted_subject_runes)

  for _, candidate := range candidates {
    sorted_candidate_runes := []rune(strings.ToLower(candidate))
    slices.Sort(sorted_candidate_runes)

    if !strings.EqualFold(subject, candidate) && slices.Equal(sorted_candidate_runes, sorted_subject_runes) {
      anagrams = append(anagrams, candidate)
    }
  }

  return
}
