package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
	"strings"
)

type Range struct {
	Lower int
	Upper int
}

type Validator func(int) bool

func processInput(data []byte) ([]Range, error) {
	var ranges []Range
	parts := strings.Split(strings.TrimSpace(string(data)), ",")
	for _, pair := range parts {
		limits := strings.Split(pair, "-")
		if len(limits) != 2 {
			return nil, fmt.Errorf("invalid range: %q", pair)
		}

		lower, err := strconv.Atoi(limits[0])
		if err != nil {
			return nil, fmt.Errorf("invalid lower bound %q: %v", limits[0], err)
		}
		upper, err := strconv.Atoi(limits[1])
		if err != nil {
			return nil, fmt.Errorf("invalid upper bound %q: %v", limits[1], err)
		}
		ranges = append(ranges, Range{Lower: lower, Upper: upper})
	}
	return ranges, nil
}

func isRepeatedTwice(n int) bool {
	s := strconv.Itoa(n)
	if len(s)%2 != 0 {
		return false
	}
	half := len(s) / 2
	return s[:half] == s[half:]
}

func isRepeatedAtLeastTwice(n int) bool {
	s := strconv.Itoa(n)
	l := len(s)

	for size := 1; size <= l/2; size++ {
		if l%size != 0 {
			continue
		}
		chunk := s[:size]
		repeated := strings.Repeat(chunk, l/size)
		if repeated == s && l/size >= 2 {
			return true
		}
	}
	return false
}

func solve(ranges []Range, v Validator) int {
	total := 0
	for _, r := range ranges {
		for n := r.Lower; n <= r.Upper; n++ {
			if v(n) {
				total += n
			}
		}
	}
	return total
}

func readInput() ([]byte, error) {
	stat, _ := os.Stdin.Stat()
	if stat.Mode()&os.ModeCharDevice == 0 {
		return io.ReadAll(os.Stdin)
	}
	if len(os.Args) > 1 {
		return os.ReadFile(os.Args[1])
	}
	return nil, fmt.Errorf("no input provided")
}

func main() {
	fmt.Println("=== Day 02 ===")

	data, err := readInput()
	if err != nil {
		log.Fatal(err)
	}

	ranges, err := processInput(data)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Part 1 Result: %d\n", solve(ranges, isRepeatedTwice))
	fmt.Printf("Part 2 Result: %d\n", solve(ranges, isRepeatedAtLeastTwice))
}
