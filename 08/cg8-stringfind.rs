// Copyright (c) esoperson
use std::str;

fn convert_u8_slice(s: &[u8]) -> Vec<i32> {
    s.iter().copied().map(|c| c.into()).collect()
}

pub fn entry(needle: &str, haystack: &str) -> Option<usize> {
    let M = needle.len();
    let N = haystack.len();
    let mut p: i32 = 0;
    let mut t: i32 = 0;
    let mut h: i32 = 1;
    let d = 256;
    let nd = convert_u8_slice(needle.as_bytes());
    let hy = convert_u8_slice(haystack.as_bytes());

    for _i in 0..M-1 {
        h = (h * 256) % 199;
    }

    for i in 0..M {
        p = (d * p + nd[i]) % 199;
        t = (d * t + hy[i]) % 199;
    }

    for i in 0..N-M+1 {
        if p == t {
            let mut f = true;
            for j in 0..M {
                if hy[i+j] != nd[j] { f = false; break; }
            }
            if f {return Some(i);}
        }
        if i < N-M {
            t = (256 * (t - hy[i] * h) + hy[i + M]) % 199;
            if t < 0 { t = t + 199; } 
        }
    }
    return None;
}

fn main() {
    println!("{:?}", entry("rocket", "rocket race"));
    println!("{:?}", entry("time", "razetime"));
    println!("{:?}", entry("lark", "gollark"));
    println!("{:?}", entry("lyric", "lyricly"));
    println!("{:?}", entry("the", "feed-the-machine"));
    println!("{:?}", entry("sci ", "kit"));
}