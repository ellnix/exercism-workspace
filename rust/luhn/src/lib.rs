/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let code = code.replace(' ', "");

    if code.len() < 2 {
        return false;
    }

    if code.chars().any(|char| char.to_digit(10).is_none()) {
        return false;
    }

    let verification_sum: u32 = code
        .chars()
        .rev()
        .map(|char| char.to_digit(10).unwrap())
        .enumerate()
        .map(|(i, a)| {
            if i % 2 == 1 {
                double_with_truncation(a)
            } else {
                a
            }
        })
        .sum();

    verification_sum % 10 == 0
}

fn double_with_truncation(x: u32) -> u32 {
    if x * 2 > 9 {
        x * 2 - 9
    } else {
        x * 2
    }
}
