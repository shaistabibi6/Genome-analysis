set terminal png tiny size 800,800
set output "spades_mummerplot.png"
set ytics ( \
 "*NODE_2_length_557694_cov_53.071509" 1.0, \
 "NODE_26_length_163_cov_30.490741" 557694.0, \
 "NODE_24_length_195_cov_29.892857" 557856.0, \
 "NODE_31_length_77_cov_30.727273" 558050.0, \
 "NODE_25_length_165_cov_26.409091" 558126.0, \
 "NODE_1_length_2057311_cov_44.385802" 558290.0, \
 "*NODE_22_length_224_cov_32.189349" 2615600.0, \
 "*NODE_28_length_126_cov_32.957746" 2615823.0, \
 "*NODE_29_length_113_cov_28.155172" 2615948.0, \
 "*NODE_14_length_375_cov_31.812500" 2616060.0, \
 "*NODE_4_length_140172_cov_37.161829" 2616434.0, \
 "*NODE_27_length_128_cov_136.301370" 2756605.0, \
 "NODE_17_length_311_cov_66.605469" 2756732.0, \
 "NODE_7_length_41991_cov_87.726393" 2757042.0, \
 "NODE_23_length_199_cov_271.888889" 2799032.0, \
 "NODE_8_length_12383_cov_107.938514" 2799230.0, \
 "NODE_16_length_332_cov_0.274368" 2811612.0, \
 "NODE_6_length_42107_cov_215.029035" 2811943.0, \
 "NODE_18_length_266_cov_76.611374" 2854049.0, \
 "NODE_19_length_249_cov_53.407216" 2854314.0, \
 "NODE_3_length_223476_cov_101.276715" 2854562.0, \
 "NODE_9_length_9417_cov_147.340953" 3078037.0, \
 "NODE_12_length_446_cov_60.820972" 3087453.0, \
 "NODE_5_length_62897_cov_74.026034" 3087898.0, \
 "NODE_10_length_3284_cov_266.337566" 3150794.0, \
 "NODE_13_length_386_cov_68.894260" 3154077.0, \
 "NODE_34_length_56_cov_68.000000" 3154462.0, \
 "NODE_15_length_356_cov_0.481728" 3154517.0, \
 "NODE_30_length_111_cov_285.053571" 3154872.0, \
 "NODE_33_length_62_cov_1.428571" 3154982.0, \
 "NODE_21_length_228_cov_73.433526" 3155043.0, \
 "NODE_11_length_3276_cov_241.102763" 3155270.0, \
 "NODE_32_length_62_cov_3.000000" 3158545.0, \
 "NODE_20_length_243_cov_60.813830" 3158606.0, \
 "" 3158881 \
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
set yrange [1:3158881]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "spades_mummerplot.fplot" title "FWD" w lp ls 1, \
 "spades_mummerplot.rplot" title "REV" w lp ls 2
