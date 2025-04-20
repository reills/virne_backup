graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    high 100
    low 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "max_cpu"
    originator "cpu"
    owner "node"
    type "extrema"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    high 100
    low 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "max_gpu"
    originator "gpu"
    owner "node"
    type "extrema"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    high 100
    low 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "max_rom"
    originator "rom"
    owner "node"
    type "extrema"
  ]
  link_attrs_setting [
    distribution "uniform"
    dtype "int"
    generative 1
    high 100
    low 50
    name "bw"
    owner "link"
    type "resource"
  ]
  link_attrs_setting [
    name "max_bw"
    originator "bw"
    owner "link"
    type "extrema"
  ]
  save_dir "dataset/garbage"
  topology [
    type "waxman"
    wm_alpha 0.5
    wm_beta 0.2
  ]
  file_name "p_net.gml"
  num_nodes 100
  type "waxman"
  wm_alpha 0.5
  wm_beta 0.2
  node [
    id 0
    label "0"
    pos 0.6191760149421494
    pos 0.3900730501698392
    cpu 92
    max_cpu 92
    gpu 96
    max_gpu 96
    rom 78
    max_rom 78
  ]
  node [
    id 1
    label "1"
    pos 0.5293000228566632
    pos 0.3430213015675889
    cpu 84
    max_cpu 84
    gpu 90
    max_gpu 90
    rom 96
    max_rom 96
  ]
  node [
    id 2
    label "2"
    pos 0.8698772159325251
    pos 0.42233038173895754
    cpu 65
    max_cpu 65
    gpu 96
    max_gpu 96
    rom 60
    max_rom 60
  ]
  node [
    id 3
    label "3"
    pos 0.7718260515324998
    pos 0.6861737365148587
    cpu 66
    max_cpu 66
    gpu 77
    max_gpu 77
    rom 57
    max_rom 57
  ]
  node [
    id 4
    label "4"
    pos 0.09196976974405613
    pos 0.12863987244364283
    cpu 86
    max_cpu 86
    gpu 94
    max_gpu 94
    rom 86
    max_rom 86
  ]
  node [
    id 5
    label "5"
    pos 0.4227417605677919
    pos 0.41562110136155794
    cpu 98
    max_cpu 98
    gpu 88
    max_gpu 88
    rom 99
    max_rom 99
  ]
  node [
    id 6
    label "6"
    pos 0.1631701203226853
    pos 0.6344185787395654
    cpu 67
    max_cpu 67
    gpu 76
    max_gpu 76
    rom 80
    max_rom 80
  ]
  node [
    id 7
    label "7"
    pos 0.23700494782903803
    pos 0.007664992719952912
    cpu 76
    max_cpu 76
    gpu 67
    max_gpu 67
    rom 74
    max_rom 74
  ]
  node [
    id 8
    label "8"
    pos 0.9068927424201163
    pos 0.6893604531968157
    cpu 50
    max_cpu 50
    gpu 50
    max_gpu 50
    rom 83
    max_rom 83
  ]
  node [
    id 9
    label "9"
    pos 0.35437110685874995
    pos 0.6024603377199289
    cpu 87
    max_cpu 87
    gpu 85
    max_gpu 85
    rom 60
    max_rom 60
  ]
  node [
    id 10
    label "10"
    pos 0.2295276337777714
    pos 0.321414165990088
    cpu 71
    max_cpu 71
    gpu 52
    max_gpu 52
    rom 86
    max_rom 86
  ]
  node [
    id 11
    label "11"
    pos 0.3531702333077291
    pos 0.34550079077651186
    cpu 91
    max_cpu 91
    gpu 88
    max_gpu 88
    rom 90
    max_rom 90
  ]
  node [
    id 12
    label "12"
    pos 0.3188821780806801
    pos 0.17202847101363472
    cpu 90
    max_cpu 90
    gpu 81
    max_gpu 81
    rom 68
    max_rom 68
  ]
  node [
    id 13
    label "13"
    pos 0.8811793982558381
    pos 0.5446545303446376
    cpu 62
    max_cpu 62
    gpu 89
    max_gpu 89
    rom 68
    max_rom 68
  ]
  node [
    id 14
    label "14"
    pos 0.0015412943392493217
    pos 0.2810812216699293
    cpu 94
    max_cpu 94
    gpu 87
    max_gpu 87
    rom 89
    max_rom 89
  ]
  node [
    id 15
    label "15"
    pos 0.2642595463515107
    pos 0.2636771839140548
    cpu 52
    max_cpu 52
    gpu 80
    max_gpu 80
    rom 51
    max_rom 51
  ]
  node [
    id 16
    label "16"
    pos 0.7861418269288317
    pos 0.0816490477956775
    cpu 84
    max_cpu 84
    gpu 62
    max_gpu 62
    rom 74
    max_rom 74
  ]
  node [
    id 17
    label "17"
    pos 0.8618938852668779
    pos 0.10439261278979217
    cpu 61
    max_cpu 61
    gpu 91
    max_gpu 91
    rom 59
    max_rom 59
  ]
  node [
    id 18
    label "18"
    pos 0.8172916077501232
    pos 0.9861034390493123
    cpu 90
    max_cpu 90
    gpu 93
    max_gpu 93
    rom 95
    max_rom 95
  ]
  node [
    id 19
    label "19"
    pos 0.6002489542151489
    pos 0.8545224506934761
    cpu 79
    max_cpu 79
    gpu 85
    max_gpu 85
    rom 95
    max_rom 95
  ]
  node [
    id 20
    label "20"
    pos 0.9621392931428437
    pos 0.25630476944528047
    cpu 87
    max_cpu 87
    gpu 61
    max_gpu 61
    rom 74
    max_rom 74
  ]
  node [
    id 21
    label "21"
    pos 0.9863193850723259
    pos 0.47084200400151666
    cpu 66
    max_cpu 66
    gpu 89
    max_gpu 89
    rom 70
    max_rom 70
  ]
  node [
    id 22
    label "22"
    pos 0.501549413701201
    pos 0.6094838210082844
    cpu 93
    max_cpu 93
    gpu 71
    max_gpu 71
    rom 86
    max_rom 86
  ]
  node [
    id 23
    label "23"
    pos 0.9770191835700197
    pos 0.07006792539684803
    cpu 94
    max_cpu 94
    gpu 75
    max_gpu 75
    rom 63
    max_rom 63
  ]
  node [
    id 24
    label "24"
    pos 0.9704567838662177
    pos 0.802921323406038
    cpu 60
    max_cpu 60
    gpu 98
    max_gpu 98
    rom 57
    max_rom 57
  ]
  node [
    id 25
    label "25"
    pos 0.538730248144507
    pos 0.9629480596061517
    cpu 86
    max_cpu 86
    gpu 51
    max_gpu 51
    rom 85
    max_rom 85
  ]
  node [
    id 26
    label "26"
    pos 0.09059775879157272
    pos 0.25877114361851083
    cpu 66
    max_cpu 66
    gpu 93
    max_gpu 93
    rom 55
    max_rom 55
  ]
  node [
    id 27
    label "27"
    pos 0.25875136632274565
    pos 0.4672707850121812
    cpu 95
    max_cpu 95
    gpu 89
    max_gpu 89
    rom 97
    max_rom 97
  ]
  node [
    id 28
    label "28"
    pos 0.27748424958163553
    pos 0.35289397395889766
    cpu 61
    max_cpu 61
    gpu 56
    max_gpu 56
    rom 69
    max_rom 69
  ]
  node [
    id 29
    label "29"
    pos 0.9857778860910295
    pos 0.6040832796038835
    cpu 64
    max_cpu 64
    gpu 52
    max_gpu 52
    rom 74
    max_rom 74
  ]
  node [
    id 30
    label "30"
    pos 0.85309248284157
    pos 0.10536866470378736
    cpu 73
    max_cpu 73
    gpu 55
    max_gpu 55
    rom 53
    max_rom 53
  ]
  node [
    id 31
    label "31"
    pos 0.46605923663130366
    pos 0.4758462331133403
    cpu 98
    max_cpu 98
    gpu 97
    max_gpu 97
    rom 51
    max_rom 51
  ]
  node [
    id 32
    label "32"
    pos 0.44478233509102816
    pos 0.6271164102346711
    cpu 55
    max_cpu 55
    gpu 92
    max_gpu 92
    rom 54
    max_rom 54
  ]
  node [
    id 33
    label "33"
    pos 0.7426086094880846
    pos 0.13700823608509793
    cpu 62
    max_cpu 62
    gpu 70
    max_gpu 70
    rom 91
    max_rom 91
  ]
  node [
    id 34
    label "34"
    pos 0.46280132753530967
    pos 0.9363537379453816
    cpu 79
    max_cpu 79
    gpu 62
    max_gpu 62
    rom 79
    max_rom 79
  ]
  node [
    id 35
    label "35"
    pos 0.053070961336659006
    pos 0.931969531760638
    cpu 65
    max_cpu 65
    gpu 77
    max_gpu 77
    rom 75
    max_rom 75
  ]
  node [
    id 36
    label "36"
    pos 0.6671678145110068
    pos 0.7019207740322693
    cpu 80
    max_cpu 80
    gpu 56
    max_gpu 56
    rom 95
    max_rom 95
  ]
  node [
    id 37
    label "37"
    pos 0.895880114461813
    pos 0.3588798657433224
    cpu 56
    max_cpu 56
    gpu 77
    max_gpu 77
    rom 94
    max_rom 94
  ]
  node [
    id 38
    label "38"
    pos 0.9050208149964033
    pos 0.6252628787718274
    cpu 83
    max_cpu 83
    gpu 61
    max_gpu 61
    rom 73
    max_rom 73
  ]
  node [
    id 39
    label "39"
    pos 0.45128406355333595
    pos 0.06673292632389105
    cpu 100
    max_cpu 100
    gpu 73
    max_gpu 73
    rom 68
    max_rom 68
  ]
  node [
    id 40
    label "40"
    pos 0.5867665841644335
    pos 0.7725636628888203
    cpu 70
    max_cpu 70
    gpu 65
    max_gpu 65
    rom 65
    max_rom 65
  ]
  node [
    id 41
    label "41"
    pos 0.9289303764840583
    pos 0.7908377745605083
    cpu 94
    max_cpu 94
    gpu 85
    max_gpu 85
    rom 96
    max_rom 96
  ]
  node [
    id 42
    label "42"
    pos 0.8498727225215652
    pos 0.8749452962843682
    cpu 76
    max_cpu 76
    gpu 96
    max_gpu 96
    rom 53
    max_rom 53
  ]
  node [
    id 43
    label "43"
    pos 0.21538410678713482
    pos 0.06506961593881178
    cpu 100
    max_cpu 100
    gpu 57
    max_gpu 57
    rom 55
    max_rom 55
  ]
  node [
    id 44
    label "44"
    pos 0.9802830196259639
    pos 0.024694525975433756
    cpu 56
    max_cpu 56
    gpu 74
    max_gpu 74
    rom 60
    max_rom 60
  ]
  node [
    id 45
    label "45"
    pos 0.08772714791690506
    pos 0.951244612337149
    cpu 79
    max_cpu 79
    gpu 73
    max_gpu 73
    rom 74
    max_rom 74
  ]
  node [
    id 46
    label "46"
    pos 0.056294072434546094
    pos 0.21920856631851426
    cpu 87
    max_cpu 87
    gpu 61
    max_gpu 61
    rom 66
    max_rom 66
  ]
  node [
    id 47
    label "47"
    pos 0.45535271447987824
    pos 0.10159821509678557
    cpu 72
    max_cpu 72
    gpu 87
    max_gpu 87
    rom 56
    max_rom 56
  ]
  node [
    id 48
    label "48"
    pos 0.1875958807588729
    pos 0.402506845190329
    cpu 59
    max_cpu 59
    gpu 74
    max_gpu 74
    rom 95
    max_rom 95
  ]
  node [
    id 49
    label "49"
    pos 0.9239221321467846
    pos 0.858823651843421
    cpu 76
    max_cpu 76
    gpu 64
    max_gpu 64
    rom 59
    max_rom 59
  ]
  node [
    id 50
    label "50"
    pos 0.9579949485079758
    pos 0.3999912926964675
    cpu 86
    max_cpu 86
    gpu 57
    max_gpu 57
    rom 57
    max_rom 57
  ]
  node [
    id 51
    label "51"
    pos 0.6138254143313653
    pos 0.45338559831273517
    cpu 58
    max_cpu 58
    gpu 97
    max_gpu 97
    rom 82
    max_rom 82
  ]
  node [
    id 52
    label "52"
    pos 0.6745666200226165
    pos 0.5219826600632324
    cpu 93
    max_cpu 93
    gpu 84
    max_gpu 84
    rom 57
    max_rom 57
  ]
  node [
    id 53
    label "53"
    pos 0.004422443765527473
    pos 0.9078683732538646
    cpu 71
    max_cpu 71
    gpu 77
    max_gpu 77
    rom 89
    max_rom 89
  ]
  node [
    id 54
    label "54"
    pos 0.5843553477730649
    pos 0.0409627485086812
    cpu 92
    max_cpu 92
    gpu 78
    max_gpu 78
    rom 87
    max_rom 87
  ]
  node [
    id 55
    label "55"
    pos 0.8473585401434213
    pos 0.5784364219890564
    cpu 75
    max_cpu 75
    gpu 94
    max_gpu 94
    rom 64
    max_rom 64
  ]
  node [
    id 56
    label "56"
    pos 0.7762491521209873
    pos 0.36007629270225117
    cpu 57
    max_cpu 57
    gpu 87
    max_gpu 87
    rom 89
    max_rom 89
  ]
  node [
    id 57
    label "57"
    pos 0.4365612261261621
    pos 0.8594900602264365
    cpu 98
    max_cpu 98
    gpu 79
    max_gpu 79
    rom 85
    max_rom 85
  ]
  node [
    id 58
    label "58"
    pos 0.18985525630369315
    pos 0.31497054622785936
    cpu 62
    max_cpu 62
    gpu 66
    max_gpu 66
    rom 81
    max_rom 81
  ]
  node [
    id 59
    label "59"
    pos 0.5694282409811728
    pos 0.20882004852983005
    cpu 63
    max_cpu 63
    gpu 54
    max_gpu 54
    rom 62
    max_rom 62
  ]
  node [
    id 60
    label "60"
    pos 0.16521643481197834
    pos 0.5307828437208475
    cpu 80
    max_cpu 80
    gpu 83
    max_gpu 83
    rom 88
    max_rom 88
  ]
  node [
    id 61
    label "61"
    pos 0.5530412669080124
    pos 0.19355913090471388
    cpu 51
    max_cpu 51
    gpu 82
    max_gpu 82
    rom 76
    max_rom 76
  ]
  node [
    id 62
    label "62"
    pos 0.9089027128235833
    pos 0.29107581164378726
    cpu 82
    max_cpu 82
    gpu 90
    max_gpu 90
    rom 75
    max_rom 75
  ]
  node [
    id 63
    label "63"
    pos 0.2753594118688205
    pos 0.4453814251305551
    cpu 99
    max_cpu 99
    gpu 75
    max_gpu 75
    rom 76
    max_rom 76
  ]
  node [
    id 64
    label "64"
    pos 0.28284141625344805
    pos 0.04581075741929297
    cpu 50
    max_cpu 50
    gpu 65
    max_gpu 65
    rom 78
    max_rom 78
  ]
  node [
    id 65
    label "65"
    pos 0.773027071117942
    pos 0.16560435900321735
    cpu 75
    max_cpu 75
    gpu 71
    max_gpu 71
    rom 94
    max_rom 94
  ]
  node [
    id 66
    label "66"
    pos 0.37367011197557365
    pos 0.8574281287340251
    cpu 54
    max_cpu 54
    gpu 92
    max_gpu 92
    rom 88
    max_rom 88
  ]
  node [
    id 67
    label "67"
    pos 0.3862643182391471
    pos 0.28200656594452855
    cpu 63
    max_cpu 63
    gpu 66
    max_gpu 66
    rom 76
    max_rom 76
  ]
  node [
    id 68
    label "68"
    pos 0.9629688595218991
    pos 0.870892613640959
    cpu 88
    max_cpu 88
    gpu 82
    max_gpu 82
    rom 95
    max_rom 95
  ]
  node [
    id 69
    label "69"
    pos 0.7868479345694265
    pos 0.3384747321137124
    cpu 86
    max_cpu 86
    gpu 99
    max_gpu 99
    rom 67
    max_rom 67
  ]
  node [
    id 70
    label "70"
    pos 0.5319083138587655
    pos 0.8107880001792065
    cpu 79
    max_cpu 79
    gpu 63
    max_gpu 63
    rom 95
    max_rom 95
  ]
  node [
    id 71
    label "71"
    pos 0.7465338310605397
    pos 0.4357674986671236
    cpu 88
    max_cpu 88
    gpu 87
    max_gpu 87
    rom 86
    max_rom 86
  ]
  node [
    id 72
    label "72"
    pos 0.2944011696517288
    pos 0.4968659055346172
    cpu 81
    max_cpu 81
    gpu 75
    max_gpu 75
    rom 87
    max_rom 87
  ]
  node [
    id 73
    label "73"
    pos 0.9362643667807407
    pos 0.12028844651008275
    cpu 83
    max_cpu 83
    gpu 95
    max_gpu 95
    rom 90
    max_rom 90
  ]
  node [
    id 74
    label "74"
    pos 0.01637096091225876
    pos 0.7039949521989038
    cpu 68
    max_cpu 68
    gpu 67
    max_gpu 67
    rom 97
    max_rom 97
  ]
  node [
    id 75
    label "75"
    pos 0.2569041760775317
    pos 0.5099355299320851
    cpu 86
    max_cpu 86
    gpu 95
    max_gpu 95
    rom 64
    max_rom 64
  ]
  node [
    id 76
    label "76"
    pos 0.0690805888696916
    pos 0.37280158218760884
    cpu 79
    max_cpu 79
    gpu 54
    max_gpu 54
    rom 86
    max_rom 86
  ]
  node [
    id 77
    label "77"
    pos 0.39262667335620904
    pos 0.593711212551342
    cpu 59
    max_cpu 59
    gpu 86
    max_gpu 86
    rom 61
    max_rom 61
  ]
  node [
    id 78
    label "78"
    pos 0.49247396431446133
    pos 0.5295024457435189
    cpu 70
    max_cpu 70
    gpu 82
    max_gpu 82
    rom 55
    max_rom 55
  ]
  node [
    id 79
    label "79"
    pos 0.5282547648502598
    pos 0.44318464266787083
    cpu 71
    max_cpu 71
    gpu 96
    max_gpu 96
    rom 84
    max_rom 84
  ]
  node [
    id 80
    label "80"
    pos 0.9711334951946512
    pos 0.8222306446173275
    cpu 86
    max_cpu 86
    gpu 88
    max_gpu 88
    rom 66
    max_rom 66
  ]
  node [
    id 81
    label "81"
    pos 0.03325300890720184
    pos 0.5329828536502852
    cpu 64
    max_cpu 64
    gpu 97
    max_gpu 97
    rom 77
    max_rom 77
  ]
  node [
    id 82
    label "82"
    pos 0.30556545636659516
    pos 0.02390154744842965
    cpu 72
    max_cpu 72
    gpu 99
    max_gpu 99
    rom 54
    max_rom 54
  ]
  node [
    id 83
    label "83"
    pos 0.7099020722073482
    pos 0.9952562095444294
    cpu 96
    max_cpu 96
    gpu 74
    max_gpu 74
    rom 72
    max_rom 72
  ]
  node [
    id 84
    label "84"
    pos 0.9293252198531561
    pos 0.8143156789036274
    cpu 53
    max_cpu 53
    gpu 68
    max_gpu 68
    rom 73
    max_rom 73
  ]
  node [
    id 85
    label "85"
    pos 0.5677920575071235
    pos 0.10816651568813063
    cpu 59
    max_cpu 59
    gpu 56
    max_gpu 56
    rom 92
    max_rom 92
  ]
  node [
    id 86
    label "86"
    pos 0.37919970434992245
    pos 0.8189457209562648
    cpu 93
    max_cpu 93
    gpu 81
    max_gpu 81
    rom 74
    max_rom 74
  ]
  node [
    id 87
    label "87"
    pos 0.7471104722973984
    pos 0.30393906404258086
    cpu 74
    max_cpu 74
    gpu 96
    max_gpu 96
    rom 78
    max_rom 78
  ]
  node [
    id 88
    label "88"
    pos 0.9607534966955481
    pos 0.4025847197242335
    cpu 94
    max_cpu 94
    gpu 64
    max_gpu 64
    rom 78
    max_rom 78
  ]
  node [
    id 89
    label "89"
    pos 0.8008102426325284
    pos 0.9533944813908027
    cpu 83
    max_cpu 83
    gpu 51
    max_gpu 51
    rom 56
    max_rom 56
  ]
  node [
    id 90
    label "90"
    pos 0.051958203551492166
    pos 0.36969193067405204
    cpu 95
    max_cpu 95
    gpu 71
    max_gpu 71
    rom 82
    max_rom 82
  ]
  node [
    id 91
    label "91"
    pos 0.8307000199933283
    pos 0.873479732860739
    cpu 100
    max_cpu 100
    gpu 95
    max_gpu 95
    rom 62
    max_rom 62
  ]
  node [
    id 92
    label "92"
    pos 0.18950178730465472
    pos 0.47381898484563134
    cpu 51
    max_cpu 51
    gpu 98
    max_gpu 98
    rom 97
    max_rom 97
  ]
  node [
    id 93
    label "93"
    pos 0.006883992624288848
    pos 0.6795247019780267
    cpu 88
    max_cpu 88
    gpu 93
    max_gpu 93
    rom 90
    max_rom 90
  ]
  node [
    id 94
    label "94"
    pos 0.37421382560432626
    pos 0.8065109399323604
    cpu 56
    max_cpu 56
    gpu 79
    max_gpu 79
    rom 86
    max_rom 86
  ]
  node [
    id 95
    label "95"
    pos 0.6103421636949059
    pos 0.48139151861318263
    cpu 84
    max_cpu 84
    gpu 83
    max_gpu 83
    rom 89
    max_rom 89
  ]
  node [
    id 96
    label "96"
    pos 0.6626067605919628
    pos 0.10914045777535386
    cpu 99
    max_cpu 99
    gpu 50
    max_gpu 50
    rom 68
    max_rom 68
  ]
  node [
    id 97
    label "97"
    pos 0.5978831945679202
    pos 0.9312066328377097
    cpu 63
    max_cpu 63
    gpu 67
    max_gpu 67
    rom 54
    max_rom 54
  ]
  node [
    id 98
    label "98"
    pos 0.07198517780395375
    pos 0.6925760158514281
    cpu 84
    max_cpu 84
    gpu 82
    max_gpu 82
    rom 99
    max_rom 99
  ]
  node [
    id 99
    label "99"
    pos 0.4522410015904915
    pos 0.49525667890199376
    cpu 81
    max_cpu 81
    gpu 73
    max_gpu 73
    rom 98
    max_rom 98
  ]
  edge [
    source 0
    target 1
    bw 89
    max_bw 89
  ]
  edge [
    source 0
    target 11
    bw 50
    max_bw 50
  ]
  edge [
    source 0
    target 12
    bw 92
    max_bw 92
  ]
  edge [
    source 0
    target 16
    bw 90
    max_bw 90
  ]
  edge [
    source 0
    target 22
    bw 89
    max_bw 89
  ]
  edge [
    source 0
    target 31
    bw 58
    max_bw 58
  ]
  edge [
    source 0
    target 37
    bw 56
    max_bw 56
  ]
  edge [
    source 0
    target 38
    bw 64
    max_bw 64
  ]
  edge [
    source 0
    target 47
    bw 93
    max_bw 93
  ]
  edge [
    source 0
    target 51
    bw 91
    max_bw 91
  ]
  edge [
    source 0
    target 56
    bw 66
    max_bw 66
  ]
  edge [
    source 0
    target 73
    bw 54
    max_bw 54
  ]
  edge [
    source 0
    target 76
    bw 62
    max_bw 62
  ]
  edge [
    source 0
    target 95
    bw 54
    max_bw 54
  ]
  edge [
    source 1
    target 11
    bw 64
    max_bw 64
  ]
  edge [
    source 1
    target 12
    bw 50
    max_bw 50
  ]
  edge [
    source 1
    target 13
    bw 50
    max_bw 50
  ]
  edge [
    source 1
    target 22
    bw 72
    max_bw 72
  ]
  edge [
    source 1
    target 31
    bw 67
    max_bw 67
  ]
  edge [
    source 1
    target 37
    bw 63
    max_bw 63
  ]
  edge [
    source 1
    target 48
    bw 66
    max_bw 66
  ]
  edge [
    source 1
    target 58
    bw 50
    max_bw 50
  ]
  edge [
    source 1
    target 62
    bw 60
    max_bw 60
  ]
  edge [
    source 1
    target 65
    bw 67
    max_bw 67
  ]
  edge [
    source 1
    target 66
    bw 62
    max_bw 62
  ]
  edge [
    source 1
    target 67
    bw 72
    max_bw 72
  ]
  edge [
    source 1
    target 69
    bw 90
    max_bw 90
  ]
  edge [
    source 1
    target 77
    bw 77
    max_bw 77
  ]
  edge [
    source 1
    target 82
    bw 57
    max_bw 57
  ]
  edge [
    source 2
    target 15
    bw 79
    max_bw 79
  ]
  edge [
    source 2
    target 20
    bw 90
    max_bw 90
  ]
  edge [
    source 2
    target 22
    bw 64
    max_bw 64
  ]
  edge [
    source 2
    target 23
    bw 54
    max_bw 54
  ]
  edge [
    source 2
    target 25
    bw 93
    max_bw 93
  ]
  edge [
    source 2
    target 37
    bw 67
    max_bw 67
  ]
  edge [
    source 2
    target 56
    bw 83
    max_bw 83
  ]
  edge [
    source 2
    target 65
    bw 66
    max_bw 66
  ]
  edge [
    source 2
    target 69
    bw 71
    max_bw 71
  ]
  edge [
    source 2
    target 78
    bw 64
    max_bw 64
  ]
  edge [
    source 3
    target 12
    bw 98
    max_bw 98
  ]
  edge [
    source 3
    target 21
    bw 68
    max_bw 68
  ]
  edge [
    source 3
    target 27
    bw 85
    max_bw 85
  ]
  edge [
    source 3
    target 32
    bw 78
    max_bw 78
  ]
  edge [
    source 3
    target 42
    bw 75
    max_bw 75
  ]
  edge [
    source 3
    target 50
    bw 60
    max_bw 60
  ]
  edge [
    source 3
    target 69
    bw 71
    max_bw 71
  ]
  edge [
    source 3
    target 78
    bw 80
    max_bw 80
  ]
  edge [
    source 3
    target 83
    bw 62
    max_bw 62
  ]
  edge [
    source 4
    target 6
    bw 82
    max_bw 82
  ]
  edge [
    source 4
    target 14
    bw 93
    max_bw 93
  ]
  edge [
    source 4
    target 17
    bw 65
    max_bw 65
  ]
  edge [
    source 4
    target 26
    bw 66
    max_bw 66
  ]
  edge [
    source 4
    target 47
    bw 96
    max_bw 96
  ]
  edge [
    source 4
    target 64
    bw 57
    max_bw 57
  ]
  edge [
    source 4
    target 75
    bw 60
    max_bw 60
  ]
  edge [
    source 4
    target 76
    bw 53
    max_bw 53
  ]
  edge [
    source 4
    target 95
    bw 81
    max_bw 81
  ]
  edge [
    source 5
    target 6
    bw 65
    max_bw 65
  ]
  edge [
    source 5
    target 11
    bw 69
    max_bw 69
  ]
  edge [
    source 5
    target 15
    bw 64
    max_bw 64
  ]
  edge [
    source 5
    target 21
    bw 81
    max_bw 81
  ]
  edge [
    source 5
    target 24
    bw 91
    max_bw 91
  ]
  edge [
    source 5
    target 27
    bw 68
    max_bw 68
  ]
  edge [
    source 5
    target 34
    bw 59
    max_bw 59
  ]
  edge [
    source 5
    target 39
    bw 55
    max_bw 55
  ]
  edge [
    source 5
    target 43
    bw 56
    max_bw 56
  ]
  edge [
    source 5
    target 77
    bw 57
    max_bw 57
  ]
  edge [
    source 5
    target 78
    bw 76
    max_bw 76
  ]
  edge [
    source 5
    target 81
    bw 88
    max_bw 88
  ]
  edge [
    source 5
    target 88
    bw 76
    max_bw 76
  ]
  edge [
    source 6
    target 27
    bw 51
    max_bw 51
  ]
  edge [
    source 6
    target 45
    bw 70
    max_bw 70
  ]
  edge [
    source 6
    target 63
    bw 65
    max_bw 65
  ]
  edge [
    source 6
    target 75
    bw 75
    max_bw 75
  ]
  edge [
    source 6
    target 76
    bw 82
    max_bw 82
  ]
  edge [
    source 6
    target 77
    bw 83
    max_bw 83
  ]
  edge [
    source 6
    target 79
    bw 64
    max_bw 64
  ]
  edge [
    source 6
    target 81
    bw 71
    max_bw 71
  ]
  edge [
    source 6
    target 86
    bw 68
    max_bw 68
  ]
  edge [
    source 7
    target 15
    bw 66
    max_bw 66
  ]
  edge [
    source 7
    target 47
    bw 66
    max_bw 66
  ]
  edge [
    source 7
    target 64
    bw 95
    max_bw 95
  ]
  edge [
    source 7
    target 67
    bw 53
    max_bw 53
  ]
  edge [
    source 8
    target 21
    bw 64
    max_bw 64
  ]
  edge [
    source 8
    target 24
    bw 94
    max_bw 94
  ]
  edge [
    source 8
    target 29
    bw 60
    max_bw 60
  ]
  edge [
    source 8
    target 38
    bw 77
    max_bw 77
  ]
  edge [
    source 8
    target 41
    bw 99
    max_bw 99
  ]
  edge [
    source 8
    target 42
    bw 55
    max_bw 55
  ]
  edge [
    source 8
    target 51
    bw 66
    max_bw 66
  ]
  edge [
    source 8
    target 62
    bw 75
    max_bw 75
  ]
  edge [
    source 8
    target 80
    bw 87
    max_bw 87
  ]
  edge [
    source 8
    target 82
    bw 83
    max_bw 83
  ]
  edge [
    source 8
    target 83
    bw 94
    max_bw 94
  ]
  edge [
    source 9
    target 10
    bw 50
    max_bw 50
  ]
  edge [
    source 9
    target 19
    bw 71
    max_bw 71
  ]
  edge [
    source 9
    target 46
    bw 51
    max_bw 51
  ]
  edge [
    source 9
    target 52
    bw 68
    max_bw 68
  ]
  edge [
    source 9
    target 58
    bw 69
    max_bw 69
  ]
  edge [
    source 9
    target 59
    bw 71
    max_bw 71
  ]
  edge [
    source 9
    target 61
    bw 95
    max_bw 95
  ]
  edge [
    source 9
    target 66
    bw 73
    max_bw 73
  ]
  edge [
    source 9
    target 75
    bw 50
    max_bw 50
  ]
  edge [
    source 9
    target 84
    bw 74
    max_bw 74
  ]
  edge [
    source 9
    target 85
    bw 84
    max_bw 84
  ]
  edge [
    source 9
    target 86
    bw 78
    max_bw 78
  ]
  edge [
    source 9
    target 92
    bw 90
    max_bw 90
  ]
  edge [
    source 9
    target 95
    bw 65
    max_bw 65
  ]
  edge [
    source 9
    target 99
    bw 71
    max_bw 71
  ]
  edge [
    source 10
    target 12
    bw 100
    max_bw 100
  ]
  edge [
    source 10
    target 14
    bw 52
    max_bw 52
  ]
  edge [
    source 10
    target 15
    bw 63
    max_bw 63
  ]
  edge [
    source 10
    target 21
    bw 82
    max_bw 82
  ]
  edge [
    source 10
    target 27
    bw 61
    max_bw 61
  ]
  edge [
    source 10
    target 39
    bw 75
    max_bw 75
  ]
  edge [
    source 10
    target 46
    bw 95
    max_bw 95
  ]
  edge [
    source 10
    target 58
    bw 99
    max_bw 99
  ]
  edge [
    source 10
    target 64
    bw 76
    max_bw 76
  ]
  edge [
    source 10
    target 71
    bw 52
    max_bw 52
  ]
  edge [
    source 10
    target 87
    bw 78
    max_bw 78
  ]
  edge [
    source 10
    target 98
    bw 68
    max_bw 68
  ]
  edge [
    source 10
    target 99
    bw 86
    max_bw 86
  ]
  edge [
    source 11
    target 31
    bw 50
    max_bw 50
  ]
  edge [
    source 11
    target 32
    bw 76
    max_bw 76
  ]
  edge [
    source 11
    target 54
    bw 83
    max_bw 83
  ]
  edge [
    source 11
    target 56
    bw 77
    max_bw 77
  ]
  edge [
    source 11
    target 58
    bw 88
    max_bw 88
  ]
  edge [
    source 11
    target 69
    bw 57
    max_bw 57
  ]
  edge [
    source 11
    target 75
    bw 88
    max_bw 88
  ]
  edge [
    source 11
    target 82
    bw 51
    max_bw 51
  ]
  edge [
    source 11
    target 86
    bw 74
    max_bw 74
  ]
  edge [
    source 11
    target 90
    bw 73
    max_bw 73
  ]
  edge [
    source 11
    target 96
    bw 73
    max_bw 73
  ]
  edge [
    source 11
    target 97
    bw 87
    max_bw 87
  ]
  edge [
    source 12
    target 17
    bw 50
    max_bw 50
  ]
  edge [
    source 12
    target 32
    bw 58
    max_bw 58
  ]
  edge [
    source 12
    target 59
    bw 56
    max_bw 56
  ]
  edge [
    source 12
    target 76
    bw 86
    max_bw 86
  ]
  edge [
    source 12
    target 89
    bw 78
    max_bw 78
  ]
  edge [
    source 13
    target 20
    bw 70
    max_bw 70
  ]
  edge [
    source 13
    target 21
    bw 68
    max_bw 68
  ]
  edge [
    source 13
    target 49
    bw 51
    max_bw 51
  ]
  edge [
    source 13
    target 55
    bw 78
    max_bw 78
  ]
  edge [
    source 13
    target 56
    bw 82
    max_bw 82
  ]
  edge [
    source 13
    target 66
    bw 58
    max_bw 58
  ]
  edge [
    source 13
    target 70
    bw 94
    max_bw 94
  ]
  edge [
    source 13
    target 97
    bw 64
    max_bw 64
  ]
  edge [
    source 14
    target 46
    bw 96
    max_bw 96
  ]
  edge [
    source 14
    target 58
    bw 94
    max_bw 94
  ]
  edge [
    source 14
    target 82
    bw 81
    max_bw 81
  ]
  edge [
    source 14
    target 86
    bw 63
    max_bw 63
  ]
  edge [
    source 15
    target 28
    bw 57
    max_bw 57
  ]
  edge [
    source 15
    target 43
    bw 57
    max_bw 57
  ]
  edge [
    source 15
    target 63
    bw 55
    max_bw 55
  ]
  edge [
    source 15
    target 76
    bw 88
    max_bw 88
  ]
  edge [
    source 15
    target 79
    bw 93
    max_bw 93
  ]
  edge [
    source 15
    target 86
    bw 69
    max_bw 69
  ]
  edge [
    source 16
    target 28
    bw 69
    max_bw 69
  ]
  edge [
    source 16
    target 30
    bw 88
    max_bw 88
  ]
  edge [
    source 16
    target 55
    bw 77
    max_bw 77
  ]
  edge [
    source 16
    target 60
    bw 55
    max_bw 55
  ]
  edge [
    source 16
    target 65
    bw 93
    max_bw 93
  ]
  edge [
    source 16
    target 69
    bw 66
    max_bw 66
  ]
  edge [
    source 16
    target 80
    bw 94
    max_bw 94
  ]
  edge [
    source 16
    target 82
    bw 99
    max_bw 99
  ]
  edge [
    source 16
    target 86
    bw 75
    max_bw 75
  ]
  edge [
    source 17
    target 44
    bw 59
    max_bw 59
  ]
  edge [
    source 17
    target 47
    bw 74
    max_bw 74
  ]
  edge [
    source 17
    target 62
    bw 62
    max_bw 62
  ]
  edge [
    source 17
    target 71
    bw 74
    max_bw 74
  ]
  edge [
    source 17
    target 73
    bw 88
    max_bw 88
  ]
  edge [
    source 17
    target 82
    bw 100
    max_bw 100
  ]
  edge [
    source 17
    target 96
    bw 81
    max_bw 81
  ]
  edge [
    source 18
    target 42
    bw 77
    max_bw 77
  ]
  edge [
    source 18
    target 52
    bw 57
    max_bw 57
  ]
  edge [
    source 18
    target 63
    bw 60
    max_bw 60
  ]
  edge [
    source 19
    target 25
    bw 93
    max_bw 93
  ]
  edge [
    source 19
    target 40
    bw 97
    max_bw 97
  ]
  edge [
    source 19
    target 55
    bw 96
    max_bw 96
  ]
  edge [
    source 19
    target 57
    bw 52
    max_bw 52
  ]
  edge [
    source 19
    target 60
    bw 57
    max_bw 57
  ]
  edge [
    source 19
    target 66
    bw 62
    max_bw 62
  ]
  edge [
    source 19
    target 70
    bw 84
    max_bw 84
  ]
  edge [
    source 19
    target 71
    bw 83
    max_bw 83
  ]
  edge [
    source 19
    target 83
    bw 62
    max_bw 62
  ]
  edge [
    source 19
    target 84
    bw 65
    max_bw 65
  ]
  edge [
    source 19
    target 95
    bw 57
    max_bw 57
  ]
  edge [
    source 20
    target 23
    bw 100
    max_bw 100
  ]
  edge [
    source 20
    target 33
    bw 92
    max_bw 92
  ]
  edge [
    source 20
    target 37
    bw 86
    max_bw 86
  ]
  edge [
    source 20
    target 44
    bw 87
    max_bw 87
  ]
  edge [
    source 20
    target 50
    bw 69
    max_bw 69
  ]
  edge [
    source 20
    target 55
    bw 83
    max_bw 83
  ]
  edge [
    source 20
    target 62
    bw 90
    max_bw 90
  ]
  edge [
    source 20
    target 87
    bw 97
    max_bw 97
  ]
  edge [
    source 21
    target 41
    bw 66
    max_bw 66
  ]
  edge [
    source 21
    target 42
    bw 69
    max_bw 69
  ]
  edge [
    source 21
    target 50
    bw 79
    max_bw 79
  ]
  edge [
    source 21
    target 55
    bw 87
    max_bw 87
  ]
  edge [
    source 21
    target 65
    bw 85
    max_bw 85
  ]
  edge [
    source 21
    target 84
    bw 77
    max_bw 77
  ]
  edge [
    source 21
    target 91
    bw 64
    max_bw 64
  ]
  edge [
    source 22
    target 31
    bw 92
    max_bw 92
  ]
  edge [
    source 22
    target 32
    bw 98
    max_bw 98
  ]
  edge [
    source 22
    target 36
    bw 95
    max_bw 95
  ]
  edge [
    source 22
    target 45
    bw 91
    max_bw 91
  ]
  edge [
    source 22
    target 66
    bw 56
    max_bw 56
  ]
  edge [
    source 22
    target 70
    bw 52
    max_bw 52
  ]
  edge [
    source 22
    target 72
    bw 97
    max_bw 97
  ]
  edge [
    source 22
    target 75
    bw 68
    max_bw 68
  ]
  edge [
    source 22
    target 78
    bw 81
    max_bw 81
  ]
  edge [
    source 22
    target 79
    bw 68
    max_bw 68
  ]
  edge [
    source 22
    target 87
    bw 99
    max_bw 99
  ]
  edge [
    source 22
    target 89
    bw 63
    max_bw 63
  ]
  edge [
    source 23
    target 33
    bw 64
    max_bw 64
  ]
  edge [
    source 23
    target 44
    bw 77
    max_bw 77
  ]
  edge [
    source 23
    target 50
    bw 76
    max_bw 76
  ]
  edge [
    source 23
    target 53
    bw 59
    max_bw 59
  ]
  edge [
    source 23
    target 54
    bw 58
    max_bw 58
  ]
  edge [
    source 23
    target 56
    bw 82
    max_bw 82
  ]
  edge [
    source 23
    target 80
    bw 92
    max_bw 92
  ]
  edge [
    source 23
    target 88
    bw 93
    max_bw 93
  ]
  edge [
    source 24
    target 38
    bw 66
    max_bw 66
  ]
  edge [
    source 24
    target 46
    bw 83
    max_bw 83
  ]
  edge [
    source 24
    target 51
    bw 53
    max_bw 53
  ]
  edge [
    source 24
    target 57
    bw 60
    max_bw 60
  ]
  edge [
    source 24
    target 79
    bw 51
    max_bw 51
  ]
  edge [
    source 25
    target 32
    bw 98
    max_bw 98
  ]
  edge [
    source 25
    target 34
    bw 90
    max_bw 90
  ]
  edge [
    source 25
    target 36
    bw 90
    max_bw 90
  ]
  edge [
    source 25
    target 51
    bw 52
    max_bw 52
  ]
  edge [
    source 25
    target 57
    bw 82
    max_bw 82
  ]
  edge [
    source 25
    target 86
    bw 95
    max_bw 95
  ]
  edge [
    source 25
    target 97
    bw 56
    max_bw 56
  ]
  edge [
    source 25
    target 98
    bw 70
    max_bw 70
  ]
  edge [
    source 26
    target 48
    bw 88
    max_bw 88
  ]
  edge [
    source 26
    target 51
    bw 66
    max_bw 66
  ]
  edge [
    source 26
    target 72
    bw 81
    max_bw 81
  ]
  edge [
    source 26
    target 75
    bw 84
    max_bw 84
  ]
  edge [
    source 26
    target 90
    bw 78
    max_bw 78
  ]
  edge [
    source 27
    target 28
    bw 87
    max_bw 87
  ]
  edge [
    source 27
    target 58
    bw 93
    max_bw 93
  ]
  edge [
    source 27
    target 60
    bw 50
    max_bw 50
  ]
  edge [
    source 27
    target 61
    bw 66
    max_bw 66
  ]
  edge [
    source 27
    target 63
    bw 57
    max_bw 57
  ]
  edge [
    source 27
    target 76
    bw 73
    max_bw 73
  ]
  edge [
    source 27
    target 79
    bw 69
    max_bw 69
  ]
  edge [
    source 28
    target 31
    bw 64
    max_bw 64
  ]
  edge [
    source 28
    target 39
    bw 93
    max_bw 93
  ]
  edge [
    source 28
    target 43
    bw 78
    max_bw 78
  ]
  edge [
    source 28
    target 46
    bw 100
    max_bw 100
  ]
  edge [
    source 28
    target 47
    bw 58
    max_bw 58
  ]
  edge [
    source 28
    target 51
    bw 96
    max_bw 96
  ]
  edge [
    source 28
    target 59
    bw 88
    max_bw 88
  ]
  edge [
    source 28
    target 61
    bw 54
    max_bw 54
  ]
  edge [
    source 28
    target 63
    bw 65
    max_bw 65
  ]
  edge [
    source 28
    target 72
    bw 84
    max_bw 84
  ]
  edge [
    source 28
    target 76
    bw 67
    max_bw 67
  ]
  edge [
    source 28
    target 97
    bw 95
    max_bw 95
  ]
  edge [
    source 29
    target 38
    bw 69
    max_bw 69
  ]
  edge [
    source 29
    target 41
    bw 98
    max_bw 98
  ]
  edge [
    source 29
    target 60
    bw 80
    max_bw 80
  ]
  edge [
    source 29
    target 98
    bw 74
    max_bw 74
  ]
  edge [
    source 30
    target 44
    bw 80
    max_bw 80
  ]
  edge [
    source 30
    target 61
    bw 59
    max_bw 59
  ]
  edge [
    source 30
    target 88
    bw 56
    max_bw 56
  ]
  edge [
    source 31
    target 32
    bw 94
    max_bw 94
  ]
  edge [
    source 31
    target 33
    bw 52
    max_bw 52
  ]
  edge [
    source 31
    target 43
    bw 52
    max_bw 52
  ]
  edge [
    source 31
    target 49
    bw 76
    max_bw 76
  ]
  edge [
    source 31
    target 67
    bw 97
    max_bw 97
  ]
  edge [
    source 31
    target 68
    bw 55
    max_bw 55
  ]
  edge [
    source 31
    target 69
    bw 84
    max_bw 84
  ]
  edge [
    source 31
    target 74
    bw 73
    max_bw 73
  ]
  edge [
    source 31
    target 82
    bw 82
    max_bw 82
  ]
  edge [
    source 31
    target 92
    bw 71
    max_bw 71
  ]
  edge [
    source 31
    target 95
    bw 52
    max_bw 52
  ]
  edge [
    source 32
    target 33
    bw 84
    max_bw 84
  ]
  edge [
    source 32
    target 57
    bw 73
    max_bw 73
  ]
  edge [
    source 32
    target 58
    bw 74
    max_bw 74
  ]
  edge [
    source 32
    target 61
    bw 96
    max_bw 96
  ]
  edge [
    source 32
    target 66
    bw 83
    max_bw 83
  ]
  edge [
    source 32
    target 67
    bw 70
    max_bw 70
  ]
  edge [
    source 32
    target 70
    bw 52
    max_bw 52
  ]
  edge [
    source 32
    target 73
    bw 50
    max_bw 50
  ]
  edge [
    source 32
    target 77
    bw 52
    max_bw 52
  ]
  edge [
    source 32
    target 78
    bw 70
    max_bw 70
  ]
  edge [
    source 32
    target 97
    bw 70
    max_bw 70
  ]
  edge [
    source 32
    target 98
    bw 66
    max_bw 66
  ]
  edge [
    source 32
    target 99
    bw 54
    max_bw 54
  ]
  edge [
    source 33
    target 59
    bw 97
    max_bw 97
  ]
  edge [
    source 33
    target 67
    bw 63
    max_bw 63
  ]
  edge [
    source 33
    target 87
    bw 78
    max_bw 78
  ]
  edge [
    source 34
    target 57
    bw 89
    max_bw 89
  ]
  edge [
    source 34
    target 58
    bw 87
    max_bw 87
  ]
  edge [
    source 34
    target 70
    bw 78
    max_bw 78
  ]
  edge [
    source 34
    target 72
    bw 68
    max_bw 68
  ]
  edge [
    source 34
    target 94
    bw 73
    max_bw 73
  ]
  edge [
    source 34
    target 95
    bw 92
    max_bw 92
  ]
  edge [
    source 35
    target 39
    bw 89
    max_bw 89
  ]
  edge [
    source 35
    target 60
    bw 78
    max_bw 78
  ]
  edge [
    source 35
    target 89
    bw 75
    max_bw 75
  ]
  edge [
    source 36
    target 38
    bw 96
    max_bw 96
  ]
  edge [
    source 36
    target 40
    bw 84
    max_bw 84
  ]
  edge [
    source 36
    target 60
    bw 50
    max_bw 50
  ]
  edge [
    source 36
    target 68
    bw 79
    max_bw 79
  ]
  edge [
    source 36
    target 74
    bw 67
    max_bw 67
  ]
  edge [
    source 36
    target 79
    bw 98
    max_bw 98
  ]
  edge [
    source 37
    target 54
    bw 79
    max_bw 79
  ]
  edge [
    source 37
    target 65
    bw 52
    max_bw 52
  ]
  edge [
    source 37
    target 68
    bw 97
    max_bw 97
  ]
  edge [
    source 37
    target 69
    bw 87
    max_bw 87
  ]
  edge [
    source 38
    target 48
    bw 94
    max_bw 94
  ]
  edge [
    source 38
    target 51
    bw 96
    max_bw 96
  ]
  edge [
    source 38
    target 52
    bw 89
    max_bw 89
  ]
  edge [
    source 38
    target 56
    bw 95
    max_bw 95
  ]
  edge [
    source 39
    target 43
    bw 75
    max_bw 75
  ]
  edge [
    source 39
    target 60
    bw 79
    max_bw 79
  ]
  edge [
    source 39
    target 84
    bw 83
    max_bw 83
  ]
  edge [
    source 40
    target 57
    bw 89
    max_bw 89
  ]
  edge [
    source 40
    target 66
    bw 74
    max_bw 74
  ]
  edge [
    source 40
    target 70
    bw 57
    max_bw 57
  ]
  edge [
    source 40
    target 76
    bw 90
    max_bw 90
  ]
  edge [
    source 40
    target 78
    bw 87
    max_bw 87
  ]
  edge [
    source 40
    target 92
    bw 71
    max_bw 71
  ]
  edge [
    source 41
    target 52
    bw 79
    max_bw 79
  ]
  edge [
    source 41
    target 68
    bw 73
    max_bw 73
  ]
  edge [
    source 41
    target 80
    bw 86
    max_bw 86
  ]
  edge [
    source 42
    target 63
    bw 58
    max_bw 58
  ]
  edge [
    source 42
    target 68
    bw 54
    max_bw 54
  ]
  edge [
    source 42
    target 86
    bw 98
    max_bw 98
  ]
  edge [
    source 42
    target 97
    bw 64
    max_bw 64
  ]
  edge [
    source 43
    target 56
    bw 88
    max_bw 88
  ]
  edge [
    source 43
    target 60
    bw 87
    max_bw 87
  ]
  edge [
    source 43
    target 64
    bw 69
    max_bw 69
  ]
  edge [
    source 43
    target 65
    bw 97
    max_bw 97
  ]
  edge [
    source 43
    target 82
    bw 60
    max_bw 60
  ]
  edge [
    source 44
    target 87
    bw 73
    max_bw 73
  ]
  edge [
    source 45
    target 48
    bw 95
    max_bw 95
  ]
  edge [
    source 45
    target 53
    bw 84
    max_bw 84
  ]
  edge [
    source 45
    target 74
    bw 85
    max_bw 85
  ]
  edge [
    source 45
    target 75
    bw 74
    max_bw 74
  ]
  edge [
    source 46
    target 48
    bw 98
    max_bw 98
  ]
  edge [
    source 46
    target 61
    bw 86
    max_bw 86
  ]
  edge [
    source 46
    target 67
    bw 89
    max_bw 89
  ]
  edge [
    source 46
    target 71
    bw 67
    max_bw 67
  ]
  edge [
    source 46
    target 76
    bw 55
    max_bw 55
  ]
  edge [
    source 47
    target 61
    bw 59
    max_bw 59
  ]
  edge [
    source 47
    target 76
    bw 89
    max_bw 89
  ]
  edge [
    source 47
    target 85
    bw 53
    max_bw 53
  ]
  edge [
    source 47
    target 92
    bw 74
    max_bw 74
  ]
  edge [
    source 47
    target 94
    bw 61
    max_bw 61
  ]
  edge [
    source 47
    target 96
    bw 90
    max_bw 90
  ]
  edge [
    source 48
    target 59
    bw 65
    max_bw 65
  ]
  edge [
    source 48
    target 72
    bw 57
    max_bw 57
  ]
  edge [
    source 48
    target 75
    bw 82
    max_bw 82
  ]
  edge [
    source 48
    target 76
    bw 95
    max_bw 95
  ]
  edge [
    source 48
    target 77
    bw 84
    max_bw 84
  ]
  edge [
    source 48
    target 79
    bw 55
    max_bw 55
  ]
  edge [
    source 49
    target 55
    bw 80
    max_bw 80
  ]
  edge [
    source 49
    target 68
    bw 86
    max_bw 86
  ]
  edge [
    source 49
    target 83
    bw 60
    max_bw 60
  ]
  edge [
    source 49
    target 84
    bw 55
    max_bw 55
  ]
  edge [
    source 50
    target 62
    bw 62
    max_bw 62
  ]
  edge [
    source 50
    target 71
    bw 66
    max_bw 66
  ]
  edge [
    source 50
    target 80
    bw 62
    max_bw 62
  ]
  edge [
    source 50
    target 89
    bw 66
    max_bw 66
  ]
  edge [
    source 50
    target 96
    bw 53
    max_bw 53
  ]
  edge [
    source 51
    target 56
    bw 74
    max_bw 74
  ]
  edge [
    source 51
    target 61
    bw 59
    max_bw 59
  ]
  edge [
    source 51
    target 62
    bw 74
    max_bw 74
  ]
  edge [
    source 51
    target 95
    bw 84
    max_bw 84
  ]
  edge [
    source 51
    target 96
    bw 79
    max_bw 79
  ]
  edge [
    source 52
    target 58
    bw 61
    max_bw 61
  ]
  edge [
    source 52
    target 69
    bw 92
    max_bw 92
  ]
  edge [
    source 52
    target 80
    bw 54
    max_bw 54
  ]
  edge [
    source 53
    target 57
    bw 100
    max_bw 100
  ]
  edge [
    source 53
    target 66
    bw 70
    max_bw 70
  ]
  edge [
    source 53
    target 77
    bw 97
    max_bw 97
  ]
  edge [
    source 53
    target 93
    bw 92
    max_bw 92
  ]
  edge [
    source 53
    target 94
    bw 89
    max_bw 89
  ]
  edge [
    source 53
    target 99
    bw 58
    max_bw 58
  ]
  edge [
    source 54
    target 62
    bw 94
    max_bw 94
  ]
  edge [
    source 54
    target 65
    bw 53
    max_bw 53
  ]
  edge [
    source 54
    target 79
    bw 87
    max_bw 87
  ]
  edge [
    source 54
    target 80
    bw 91
    max_bw 91
  ]
  edge [
    source 55
    target 59
    bw 79
    max_bw 79
  ]
  edge [
    source 55
    target 66
    bw 54
    max_bw 54
  ]
  edge [
    source 55
    target 78
    bw 56
    max_bw 56
  ]
  edge [
    source 55
    target 80
    bw 66
    max_bw 66
  ]
  edge [
    source 55
    target 84
    bw 80
    max_bw 80
  ]
  edge [
    source 55
    target 93
    bw 66
    max_bw 66
  ]
  edge [
    source 56
    target 71
    bw 53
    max_bw 53
  ]
  edge [
    source 56
    target 73
    bw 96
    max_bw 96
  ]
  edge [
    source 56
    target 85
    bw 85
    max_bw 85
  ]
  edge [
    source 57
    target 58
    bw 91
    max_bw 91
  ]
  edge [
    source 57
    target 60
    bw 71
    max_bw 71
  ]
  edge [
    source 57
    target 66
    bw 60
    max_bw 60
  ]
  edge [
    source 57
    target 76
    bw 76
    max_bw 76
  ]
  edge [
    source 57
    target 94
    bw 92
    max_bw 92
  ]
  edge [
    source 57
    target 97
    bw 53
    max_bw 53
  ]
  edge [
    source 58
    target 74
    bw 100
    max_bw 100
  ]
  edge [
    source 58
    target 95
    bw 84
    max_bw 84
  ]
  edge [
    source 58
    target 99
    bw 91
    max_bw 91
  ]
  edge [
    source 59
    target 61
    bw 84
    max_bw 84
  ]
  edge [
    source 59
    target 67
    bw 83
    max_bw 83
  ]
  edge [
    source 59
    target 77
    bw 90
    max_bw 90
  ]
  edge [
    source 59
    target 85
    bw 54
    max_bw 54
  ]
  edge [
    source 60
    target 77
    bw 90
    max_bw 90
  ]
  edge [
    source 60
    target 81
    bw 90
    max_bw 90
  ]
  edge [
    source 60
    target 95
    bw 80
    max_bw 80
  ]
  edge [
    source 61
    target 68
    bw 51
    max_bw 51
  ]
  edge [
    source 61
    target 71
    bw 53
    max_bw 53
  ]
  edge [
    source 61
    target 82
    bw 59
    max_bw 59
  ]
  edge [
    source 61
    target 85
    bw 61
    max_bw 61
  ]
  edge [
    source 62
    target 65
    bw 61
    max_bw 61
  ]
  edge [
    source 62
    target 71
    bw 97
    max_bw 97
  ]
  edge [
    source 62
    target 96
    bw 65
    max_bw 65
  ]
  edge [
    source 63
    target 72
    bw 100
    max_bw 100
  ]
  edge [
    source 63
    target 81
    bw 98
    max_bw 98
  ]
  edge [
    source 63
    target 85
    bw 55
    max_bw 55
  ]
  edge [
    source 63
    target 87
    bw 88
    max_bw 88
  ]
  edge [
    source 64
    target 76
    bw 81
    max_bw 81
  ]
  edge [
    source 64
    target 90
    bw 89
    max_bw 89
  ]
  edge [
    source 65
    target 73
    bw 98
    max_bw 98
  ]
  edge [
    source 65
    target 85
    bw 98
    max_bw 98
  ]
  edge [
    source 65
    target 87
    bw 60
    max_bw 60
  ]
  edge [
    source 65
    target 91
    bw 87
    max_bw 87
  ]
  edge [
    source 65
    target 95
    bw 92
    max_bw 92
  ]
  edge [
    source 65
    target 97
    bw 74
    max_bw 74
  ]
  edge [
    source 66
    target 86
    bw 59
    max_bw 59
  ]
  edge [
    source 66
    target 94
    bw 62
    max_bw 62
  ]
  edge [
    source 67
    target 69
    bw 59
    max_bw 59
  ]
  edge [
    source 67
    target 72
    bw 89
    max_bw 89
  ]
  edge [
    source 67
    target 90
    bw 77
    max_bw 77
  ]
  edge [
    source 67
    target 96
    bw 73
    max_bw 73
  ]
  edge [
    source 68
    target 80
    bw 53
    max_bw 53
  ]
  edge [
    source 68
    target 83
    bw 71
    max_bw 71
  ]
  edge [
    source 68
    target 94
    bw 52
    max_bw 52
  ]
  edge [
    source 69
    target 72
    bw 59
    max_bw 59
  ]
  edge [
    source 69
    target 77
    bw 92
    max_bw 92
  ]
  edge [
    source 69
    target 91
    bw 68
    max_bw 68
  ]
  edge [
    source 70
    target 77
    bw 98
    max_bw 98
  ]
  edge [
    source 70
    target 83
    bw 87
    max_bw 87
  ]
  edge [
    source 70
    target 85
    bw 56
    max_bw 56
  ]
  edge [
    source 70
    target 86
    bw 100
    max_bw 100
  ]
  edge [
    source 70
    target 91
    bw 87
    max_bw 87
  ]
  edge [
    source 71
    target 73
    bw 97
    max_bw 97
  ]
  edge [
    source 71
    target 83
    bw 88
    max_bw 88
  ]
  edge [
    source 72
    target 78
    bw 92
    max_bw 92
  ]
  edge [
    source 72
    target 87
    bw 89
    max_bw 89
  ]
  edge [
    source 72
    target 92
    bw 71
    max_bw 71
  ]
  edge [
    source 72
    target 93
    bw 76
    max_bw 76
  ]
  edge [
    source 73
    target 85
    bw 70
    max_bw 70
  ]
  edge [
    source 73
    target 87
    bw 57
    max_bw 57
  ]
  edge [
    source 73
    target 88
    bw 75
    max_bw 75
  ]
  edge [
    source 73
    target 96
    bw 90
    max_bw 90
  ]
  edge [
    source 74
    target 90
    bw 64
    max_bw 64
  ]
  edge [
    source 75
    target 81
    bw 58
    max_bw 58
  ]
  edge [
    source 75
    target 92
    bw 61
    max_bw 61
  ]
  edge [
    source 76
    target 86
    bw 55
    max_bw 55
  ]
  edge [
    source 76
    target 90
    bw 53
    max_bw 53
  ]
  edge [
    source 77
    target 79
    bw 87
    max_bw 87
  ]
  edge [
    source 77
    target 87
    bw 56
    max_bw 56
  ]
  edge [
    source 77
    target 90
    bw 82
    max_bw 82
  ]
  edge [
    source 77
    target 94
    bw 99
    max_bw 99
  ]
  edge [
    source 77
    target 99
    bw 82
    max_bw 82
  ]
  edge [
    source 78
    target 79
    bw 76
    max_bw 76
  ]
  edge [
    source 78
    target 91
    bw 64
    max_bw 64
  ]
  edge [
    source 78
    target 92
    bw 79
    max_bw 79
  ]
  edge [
    source 78
    target 95
    bw 77
    max_bw 77
  ]
  edge [
    source 78
    target 99
    bw 96
    max_bw 96
  ]
  edge [
    source 79
    target 85
    bw 61
    max_bw 61
  ]
  edge [
    source 79
    target 95
    bw 63
    max_bw 63
  ]
  edge [
    source 79
    target 99
    bw 95
    max_bw 95
  ]
  edge [
    source 80
    target 84
    bw 59
    max_bw 59
  ]
  edge [
    source 80
    target 89
    bw 79
    max_bw 79
  ]
  edge [
    source 80
    target 91
    bw 74
    max_bw 74
  ]
  edge [
    source 81
    target 98
    bw 56
    max_bw 56
  ]
  edge [
    source 82
    target 85
    bw 67
    max_bw 67
  ]
  edge [
    source 82
    target 90
    bw 77
    max_bw 77
  ]
  edge [
    source 85
    target 99
    bw 86
    max_bw 86
  ]
  edge [
    source 87
    target 96
    bw 64
    max_bw 64
  ]
  edge [
    source 89
    target 91
    bw 74
    max_bw 74
  ]
  edge [
    source 91
    target 95
    bw 59
    max_bw 59
  ]
  edge [
    source 95
    target 99
    bw 98
    max_bw 98
  ]
]
