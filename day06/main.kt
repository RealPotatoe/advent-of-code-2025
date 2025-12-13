data class Problem(val numbers: List<Long>, val operator: Char) {
    fun solve(): Long {
        return numbers.reduce { acc, next ->
            when (operator) {
                '+' -> acc + next
                '*' -> acc * next
                else -> throw IllegalArgumentException("Unknown op: $operator")
            }
        }
    }
}

fun main() {
    val input = System.`in`.bufferedReader().readText()
    val lines = input.lines().filter { it.isNotEmpty() }

    println("=== Day 06 ===")

    val part1 = solvePart1(lines)
    println("Part 1: $part1")

    val part2 = solvePart2(lines)
    println("Part 2: $part2")
}

fun solvePart1(lines: List<String>): Long {
    val operatorLine = lines.last()
    val numberLines = lines.dropLast(1)

    val operators = operatorLine.trim().split(Regex("\\s+"))

    val columns =
            numberLines
                    .map { line -> line.trim().split(Regex("\\s+")).map { it.toLong() } }
                    .transpose()

    return columns.mapIndexed { i, nums -> Problem(nums, operators[i][0]).solve() }.sum()
}

fun solvePart2(lines: List<String>): Long {
    val maxWidth = lines.maxOf { it.length }
    val grid = lines.map { it.padEnd(maxWidth, ' ') }

    val blocks = splitByEmptyColumns(grid)

    return blocks.sumOf { block -> solveVerticalBlock(block) }
}

fun splitByEmptyColumns(lines: List<String>): List<List<String>> {
    val blocks = mutableListOf<List<String>>()
    val height = lines.size
    val width = lines[0].length

    var currentBlock = List(height) { StringBuilder() }
    var isBlockEmpty = true

    for (col in 0 until width) {
        val isSeparator = lines.all { it[col] == ' ' }

        if (isSeparator) {
            if (!isBlockEmpty) {
                blocks.add(currentBlock.map { it.toString() })
                currentBlock = List(height) { StringBuilder() }
                isBlockEmpty = true
            }
        } else {
            lines.forEachIndexed { row, line -> currentBlock[row].append(line[col]) }
            isBlockEmpty = false
        }
    }
    if (!isBlockEmpty) blocks.add(currentBlock.map { it.toString() })
    return blocks
}

fun solveVerticalBlock(block: List<String>): Long {
    val operator = block.last().trim()[0]
    val numberGrid = block.dropLast(1)

    val numbers =
            numberGrid
                    .map { it.toList() }
                    .transpose()
                    .map { chars -> chars.joinToString("").trim() }
                    .filter { it.isNotEmpty() }
                    .map { it.toLong() }
                    .reversed()

    return Problem(numbers, operator).solve()
}

fun <T> List<List<T>>.transpose(): List<List<T>> {
    if (this.isEmpty() || this[0].isEmpty()) return emptyList()
    val width = this[0].size
    return (0 until width).map { col -> this.map { row -> row[col] } }
}
