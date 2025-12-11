256 constant max-line-len
1024 constant max-ranges

create line-buffer max-line-len allot
create range-buffer max-ranges 2 * cells allot
variable range-count
create swap-temp 2 cells allot

: fetch-line ( -- u flag )
    line-buffer max-line-len stdin read-line throw
;

: range-addr ( index -- addr )
    2 * cells range-buffer +
;

: append-range ( start end -- )
    range-count @ range-addr
    tuck cell+ !
    !
    1 range-count +!
;

: read-range ( index -- start end )
    range-addr
    dup @
    swap cell+ @
;

: parse-ranges ( -- )
    begin
        fetch-line
        over 0> and
    while
        line-buffer swap
        0 0 2swap
        >number

        1 /string

        0 0 2swap
        >number
        2drop
        
        d>s -rot d>s swap
        
        append-range
    repeat
    drop
;

: swap-ranges ( i1 i2 -- )
    range-addr swap range-addr ( addr1 addr2 )
    over swap-temp 2 cells move
    dup 2 pick 2 cells move
    swap-temp swap 2 cells move
    drop
;

: sort-ranges ( -- )
    range-count @ 2 < if exit then
    range-count @ 1- 0 do
        range-count @ 1- 0 do
            i read-range drop
            i 1+ read-range drop
            > if
                i i 1+ swap-ranges
            then
        loop
    loop
;

: merge-overlapping-ranges ( -- )
    sort-ranges
    range-count @ 2 < if exit then

    0
    range-count @ 1 do
        dup read-range nip
        i read-range drop
        
        swap 1+
        <= if
            dup read-range nip
            i read-range nip
            max
            over range-addr cell+ !
        else
            1+
            i read-range
            
            2 pick range-addr
            tuck cell+ !
            !
        then
    loop
    1+ range-count !
;

: count-fresh-ingredients ( -- n )
    0 ( count )
    begin
        fetch-line ( count u flag )
    while ( count u )
        dup 0= if 
            drop 
        else
            line-buffer swap ( count addr u )
            0 0 2swap ( count 0 0 addr u )
            >number ( count ud addr' u' )
            2drop d>s ( count n )

            0 ( count n flag )
            range-count @ 0 do
                over i read-range ( count n flag n start end )
                1+ within ( count n flag bool )
                if
                    drop -1 ( count n true ) 
                    leave
                then
            loop

            swap drop ( count flag )
            if 1+ then ( count' )
        then
    repeat
    drop
;

: count-available-ids ( -- n )
    0 ( accumulator )
    range-count @ 0 do
        i read-range ( acc start end )
        swap - ( acc diff )
        1+ ( acc count )
        + ( acc' )
    loop
;

: main ( -- )
    parse-ranges
    merge-overlapping-ranges

    ." === Day 05 ===" cr
    
    count-fresh-ingredients
    ." Part 1: " . cr

    count-available-ids
    ." Part 2: " . cr
;

main
bye