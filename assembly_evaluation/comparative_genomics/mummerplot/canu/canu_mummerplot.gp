set terminal png tiny size 800,800
set output "canu_mummerplot.png"
set ytics ( \
 "tig00000001" 1.0, \
 "tig00000009" 2763566.0, \
 "tig00000007" 2780048.0, \
 "tig00000006" 2796091.0, \
 "tig00000005" 2811105.0, \
 "tig00000004" 2851117.0, \
 "tig00000008" 2865850.0, \
 "tig00000002" 2890685.0, \
 "tig00000003" 3106684.0, \
 "" 3135564 \
)
set size 1,1
set grid
unset key
set border 10
set tics scale 0
set xlabel "CP014529.1"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
set xrange [1:2765010]
set yrange [1:3135564]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "canu_mummerplot.fplot" title "FWD" w lp ls 1, \
 "canu_mummerplot.rplot" title "REV" w lp ls 2
