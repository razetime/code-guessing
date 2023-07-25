use rand::prelude::*;
use std::collections::VecDeque;
use std::iter::FromIterator;

fn adjacent(
    x: isize,
    y: isize,
    width: isize,
    height: isize,
) -> impl Iterator<Item = (usize, usize)> {
    vec![(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]
        .into_iter()
        .filter(move |&(a, b)| a < width && b < height && a >= 0 && b >= 0)
        .map(|(x, y)| (x as usize, y as usize))
}

fn entry(grid: Vec<bool>, width: usize, _height: usize, x: usize, y: usize) -> Vec<bool> {
    let mut result: Vec<bool> = grid;
    result[x + width * y] = true;
    let mut pairs: VecDeque<(usize, usize)> = VecDeque::from_iter([(x, y)]);
    while !pairs.is_empty() {
        let (x1, y1) = pairs.pop_front().unwrap();
        result[x1 + width * y1] = true;
        for (x2, y2) in adjacent(x1 as isize, y1 as isize, width as isize, _height as isize) {
            if !result[x2 + width * y2] {
                result[x2 + width * y2] = true;
                pairs.push_back((x2, y2));
            }
        }
    }
    result
}

fn disp(grid: Vec<bool>, width: usize) {
    for (i, &item) in grid.iter().enumerate() {
        if i % width == 0 {
            println!();
        }
        print!("{}", if item { "#" } else { "." });
    }
    println!()
}

fn debug(grid: Vec<bool>, width: usize, _height: usize, x: usize, y: usize) {
    println!("x = {}, y = {}", x, y);
    let out: Vec<bool> = entry(grid.clone(), width, _height, x, y);
    disp(grid, width);
    println!("---");
    disp(out, width);
    println!("===");
}

fn rand_debug() {
    let mut rng = rand::thread_rng();
    let width: usize = rng.gen_range(10..20);
    let height: usize = rng.gen_range(10..20);
    let x: usize = rng.gen_range(0..width);
    let y: usize = rng.gen_range(0..height);
    let size: usize = width * height;
    let mut grid: Vec<bool> = Vec::with_capacity(size);
    for _ in 0..size {
        grid.push(rand::random());
    }
    debug(grid, width, height, x, y);
}

fn main() {
    debug(
        vec![
            false, true, false, false, false, false, false, true, false, false, true, true, false,
            false, false, false, true, true, true, true, false, false, true, false, false,
        ],
        5,
        5,
        4,
        1,
    );
    for _ in 0..20 {
        rand_debug();
    }
}
