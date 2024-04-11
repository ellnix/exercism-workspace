pub fn abbreviate(phrase: &str) -> String {
    let chars: Vec<char> = format!(" {phrase}").replace('_', "").chars().collect();

    chars
        .windows(2)
        .filter(|pair| {
            let is_camel = pair[0].is_ascii_lowercase() && pair[1].is_ascii_uppercase();
            let is_new_word =
                (pair[0].is_ascii_whitespace() || pair[0] == '-') && pair[1].is_ascii_alphabetic();

            is_new_word || is_camel
        })
        .map(|pair| pair[1].to_ascii_uppercase())
        .collect()
}
