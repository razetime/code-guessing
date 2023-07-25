use std::env;
use std::fs;
use std::io::Read;

fn compile(inp: String) -> String {
    let mut stack: Vec<usize> = Vec::new();
    let is: Vec<char> = inp.chars().collect();
    let mut brk: usize = 0;
    let mut i = 0;
    let mut out: String = "".to_string(); 
    while i < inp.chars().count() {
        out += &(match is[i] {
            '+' | '-' | '<' | '>' => {
                let cmd: String = match is[i] {'+' => "add", '-' => "sub", '<' => "mvl", '>' => "mvr", _ => "nop"}.to_string();
                let ori: char = is[i];
                let mut ctr = 0;
                while i+ctr < inp.chars().count() && is[i+ctr] == ori {
                    ctr += 1;
                }
                i += ctr-1;
                format!("{} {}",cmd,ctr)
            },
            '.' => { "sio 0".to_string() },
            ',' => { "sio 1".to_string() },
            '[' => {
                stack.push(brk);
                brk += 1;
                format!("jfo {:?}",brk-1)
            },
            ']' => {
                format!("jba {:?}",stack.pop().unwrap())
            },
            _ => { "".to_string() }
        } + "\n");
        i += 1;
    } 
    out
}
fn run(inp: String) {
    let lns: Vec<&str> = inp.trim_end().lines().collect();
    let mut i = 0;
    let mut ptr = 0;
    let mut tape: [u8; 30_000] = [0; 30_000]; 
    while i < lns.len() {
        let stmt = lns[i].split_whitespace().collect::<Vec<&str>>();
        let cmd = stmt[0];
        let num = stmt[1].parse::<i64>().unwrap();
        match cmd {
            "add" => { tape[ptr] = tape[ptr].overflowing_add(num as u8).0; },
            "sub" => { tape[ptr] = tape[ptr].overflowing_sub(num as u8).0; },
            "mvl" => { ptr -= num as usize;    },
            "mvr" => { ptr += num as usize;    },
            "sio" => {
                if num != 0 {
                    tape[ptr] = std::io::stdin().bytes().next().and_then(|result| result.ok()).map(|byte| byte as u8).unwrap();
                } else {
                    print!("{}",tape[ptr] as char);
                }
            },
            "jfo" => {
                if tape[ptr] == 0 {
                    let chk = format!("jba {}",num);
                    while lns[i].to_string() != chk {
                        i += 1;
                    }
                }
            },
            "jba" => {
                let chk = format!("jfo {}",num);
                while lns[i].to_string() != chk {
                    i -= 1;
                }
                i -= 1;
            },
            _ => { panic!("Malformed Code"); }
        }
            
        i += 1;
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    
    if args[1] == "-c" {
        let read: String = fs::read_to_string(&args[2]).expect("File Read Error");
        fs::write(&args[3],compile(read)).expect("File Write Error");
    } else if args[1] == "-r" {
        let read: String = fs::read_to_string(&args[2]).expect("File Read Error");
        run(read);
    } else {
        println!("Usage: cg13 (-c infile outfile | -r file)");
    }
}
