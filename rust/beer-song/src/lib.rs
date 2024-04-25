use itertools::Itertools;

pub fn verse(n: u32) -> String {
    match n {
        0 => {
            "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n".to_string()
        }
        1 => {
            "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n".to_string()
        }
        _ => {
            let bottle = if n == 2 { "bottle" } else { "bottles" };
            format!("{n} bottles of beer on the wall, {n} bottles of beer.\nTake one down and pass it around, {} {} of beer on the wall.\n", n-1, bottle)
        }
    }
}

pub fn sing(start: u32, end: u32) -> String {
    (end..=start).rev().map(verse).intersperse("\n".to_string()).collect()
}
