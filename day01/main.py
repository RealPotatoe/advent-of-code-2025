import sys

START_POSITION = 50


def process_input(data):
    return [
        (
            int(line.strip()[1:])
            if line.strip().startswith("R")
            else -int(line.strip()[1:])
        )
        for line in data
    ]


def solve_part1(numbers):
    count = 0
    total = START_POSITION

    for number in numbers:
        total = (total + number) % 100
        if total == 0:
            count += 1
    return count


def solve_part2(numbers):
    count = 0
    current_abs = START_POSITION

    for number in numbers:
        prev_abs = current_abs
        current_abs += number
        if number > 0:
            count += (current_abs // 100) - (prev_abs // 100)
        else:
            count += ((prev_abs - 1) // 100) - ((current_abs - 1) // 100)

    return count


def main():
    print("=== Day 01 ===")

    if len(sys.argv) < 1:
        print("Error: No file specified", file=sys.stderr)
        sys.exit(1)

    data = sys.stdin.readlines()
    numbers = process_input(data)

    print(f"Part 1: {solve_part1(numbers)}")
    print(f"Part 2: {solve_part2(numbers)}")


if __name__ == "__main__":
    main()
