# Advent of Code 2025 🎄

My [Advent of Code](https://adventofcode.com/) journey, solving each day in a different language.

This repo uses **Nix Flakes** to manage dependencies. Each day is a contained environment with its own toolchain, but all are orchestrated by a root flake for easy running.

## Language Roadmap

| Day    | Language                |
| :----- | :---------------------- |
| **01** | 🐍 **Python**            |
| **02** | 🐹 **Go**                |
| **03** | 🦀 **Rust**              |
| **04** | λ **Haskell**           |
| **05** | 🦕 **TypeScript** (Deno) |
| **06** | **Kotlin**              |
| **07** | #️⃣ **C#**                |
| **08** | ➕ **C++**               |
| **09** | 💧 **Elixir**            |
| **10** | ⚡ **Zig**               |
| **11** | 🐫 **OCaml**             |
| **12** | 🌙 **Lua**               |

## Running Solutions

You can run any solution directly from the root of the repository without installing the specific language globally. Nix will fetch the correct runtime and execute the solution.

```bash
# Run Day 1
nix run .#day01
```

## Development Workflow

To work on a specific day, enter its directory and run `nix develop`. This will create a shell environment that has all the necessary tools for that day's language.

```bash
cd day01
nix develop

# Python
python main.py

# Rust
cargo run

# Go
go run .
```

... you get the idea.

## Fetching Inputs

I included a script to fetch puzzle inputs automatically.

First, get your **session cookie** from [Advent of Code](https://adventofcode.com/) (`F12` > Application > Cookies > Copy the Value from `session`).
Also, please change the User Agent string inside `fetch_inputs.sh` to your contact.

```
export AOC_SESSION_COOKIE="your_session_string"
./fetch_inputs.sh
```

## Project Structure

* `flake.nix` Root Nix flake, connects all days and makes them share the same `nixpkgs`.
* `fetch_inputs.sh` Utility to fetch all available input files.
* `dayXX/`:
  * `flake.nix`: Configures the specific toolchain for that day's language.
  * `main.*`: The solution code.
