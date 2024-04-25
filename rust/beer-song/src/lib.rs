use itertools::Itertools;
use indoc::indoc;

pub fn verse(n: u32) -> String {
    match n {
        0 => indoc! { "
            No more bottles of beer on the wall, no more bottles of beer.
            Go to the store and buy some more, 99 bottles of beer on the wall.
        " }.to_string(),
        1 => indoc! { "
            1 bottle of beer on the wall, 1 bottle of beer.
            Take it down and pass it around, no more bottles of beer on the wall.
        " }.to_string(),
        _ => {
            let bottle = if n - 1 == 1 { "bottle" } else { "bottles" };

            format!("{n} bottles of beer on the wall, {n} bottles of beer.\n") + 
                &format!("Take one down and pass it around, {} {} of beer on the wall.\n", n-1, bottle)
        }
    }
}

pub fn sing(start: u32, end: u32) -> String {
    (end..=start).rev().map(verse).intersperse("\n".to_string()).collect()
}
