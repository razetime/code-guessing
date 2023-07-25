use rand::prelude::*;

fn maze(w: usize, h: usize) -> Vec<bool> {
    let mut vec = (0..w * h)
        .into_iter()
        .map(|_| -> bool { random() })
        .collect::<Vec<bool>>();
    for _ in 0..100 {
        let mut next = vec![false; w * h];
        for i in 0..(w * h) {
            let mut count = 0;
            for j in [
                vec.get(i - w - 1),
                vec.get(i - w),
                vec.get(i - w + 1),
                vec.get(i - 1),
                vec.get(i + 1),
                vec.get(i + w - 1),
                vec.get(i + w),
                vec.get(i + w + 1),
            ] {
                match j {
                    Some(true) => count += 1,
                    _ => (),
                }
            }
            if vec[i] {
                next[i] = count >= 1 && count <= 5;
            } else {
                next[i] = count == 3;
            }
        }
        vec = next;
    }
    return vec;
}

fn main() {
    let res = maze(10, 10);
    for (i, j) in res.iter().enumerate() {
        if *j {
            print!("#")
        } else {
            print!(" ")
        }
        if (i + 1) % 10 == 0 {
            println!("")
        }
    }
}
