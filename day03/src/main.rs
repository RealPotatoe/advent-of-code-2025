use std::io::{self, Read};

fn main() -> io::Result<()> {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input)?;

    let mut total_sum_p1: u64 = 0;
    let mut total_sum_p2: u64 = 0;

    for line in input.lines() {
        let digits: Vec<u8> = line
            .bytes()
            .filter(|b| b.is_ascii_digit())
            .map(|b| b - b'0')
            .collect();

        total_sum_p1 += get_max_subsequence(&digits, 2);
        total_sum_p2 += get_max_subsequence(&digits, 12);
    }

    println!("=== Day03 ===");
    println!("Part 1 (Length 2): {}", total_sum_p1);
    println!("Part 2 (Length 12): {}", total_sum_p2);

    Ok(())
}

fn get_max_subsequence(digits: &[u8], k: usize) -> u64 {
    if digits.len() < k {
        return 0;
    }

    let mut drops = digits.len() - k;
    let mut stack: Vec<u8> = Vec::with_capacity(k);

    for &digit in digits {
        while let Some(&top) = stack.last() {
            if digit > top && drops > 0 {
                stack.pop();
                drops -= 1;
            } else {
                break;
            }
        }
        stack.push(digit);
    }
    stack.truncate(k);
    stack.iter().fold(0u64, |acc, &d| acc * 10 + (d as u64))
}
