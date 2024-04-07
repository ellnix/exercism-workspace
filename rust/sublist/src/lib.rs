#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(a: &[T], b: &[T]) -> Comparison {
    if a == b { 
        return Comparison::Equal 
    } else if b.is_empty() || a.windows(b.len()).any(|sublist| sublist == b) {
        Comparison::Superlist
    } else if a.is_empty() || b.windows(a.len()).any(|sublist| sublist == a) {
        Comparison::Sublist
    } else {
        Comparison::Unequal
    }
}
