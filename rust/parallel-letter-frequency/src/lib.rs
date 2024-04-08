use std::{
    collections::HashMap, thread
};

type FrequencyMap = HashMap<char, usize>;

pub fn frequency(input: &[&str], worker_count: usize) -> FrequencyMap {
    match input.len() {
        0 => FrequencyMap::new(),
        n if n < 100 => count(input),
        _ => thread::scope(|s| {
            let mut threads = Vec::with_capacity(worker_count);
            for chunk in input.chunks(input.len() / worker_count + 1) {
                threads.push(s.spawn(|| count(chunk)))
            };

            threads.into_iter().fold(FrequencyMap::new(), |mut acc, handle| {
                for (k, v) in handle.join().unwrap().into_iter() {
                    *acc.entry(k).or_default() += v
                };
                acc
            })
        })
    }
}

fn count(input: &[&str]) -> FrequencyMap {
    let mut freq = HashMap::new();

    for line in input {
        for char in line.chars().filter(|char| char.is_alphabetic()) {
            *freq.entry(char.to_ascii_lowercase()).or_default() += 1
        }
    }

    freq
}

