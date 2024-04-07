use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &'a [&str]) -> HashSet<&'a str> {
    let lowered_word = word.to_lowercase();

    possible_anagrams
        .iter()
        .filter(|ana| {
            let lowered_ana = ana.to_lowercase();

            lowered_word != lowered_ana
                && word.len() == ana.len()
                && lowered_ana.chars().all(|char| {
                    lowered_ana.matches(char).count() == lowered_word.matches(char).count()
                })
        })
        .cloned()
        .collect()
}
