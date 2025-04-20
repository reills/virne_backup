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
  save_dir "dataset/results-seq-sfc"
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
    pos 0.5012377937849722
    pos 0.2177672303598901
    cpu 64
    max_cpu 64
    gpu 58
    max_gpu 58
    rom 95
    max_rom 95
  ]
  node [
    id 1
    label "1"
    pos 0.13122398625561216
    pos 0.568171034129447
    cpu 62
    max_cpu 62
    gpu 74
    max_gpu 74
    rom 53
    max_rom 53
  ]
  node [
    id 2
    label "2"
    pos 0.6321235394354785
    pos 0.6043583238985931
    cpu 50
    max_cpu 50
    gpu 98
    max_gpu 98
    rom 53
    max_rom 53
  ]
  node [
    id 3
    label "3"
    pos 0.44381444729569064
    pos 0.4101740449335102
    cpu 54
    max_cpu 54
    gpu 80
    max_gpu 80
    rom 70
    max_rom 70
  ]
  node [
    id 4
    label "4"
    pos 0.4872459393476586
    pos 0.2104766932830947
    cpu 94
    max_cpu 94
    gpu 90
    max_gpu 90
    rom 56
    max_rom 56
  ]
  node [
    id 5
    label "5"
    pos 0.7376243927296975
    pos 0.6806812433850502
    cpu 70
    max_cpu 70
    gpu 99
    max_gpu 99
    rom 89
    max_rom 89
  ]
  node [
    id 6
    label "6"
    pos 0.19774994369676258
    pos 0.65683744038852
    cpu 96
    max_cpu 96
    gpu 93
    max_gpu 93
    rom 51
    max_rom 51
  ]
  node [
    id 7
    label "7"
    pos 0.7228380889120012
    pos 0.8981778610812058
    cpu 97
    max_cpu 97
    gpu 62
    max_gpu 62
    rom 56
    max_rom 56
  ]
  node [
    id 8
    label "8"
    pos 0.6489834783739696
    pos 0.3523964235277003
    cpu 90
    max_cpu 90
    gpu 90
    max_gpu 90
    rom 52
    max_rom 52
  ]
  node [
    id 9
    label "9"
    pos 0.9187172279576759
    pos 0.04141400824699637
    cpu 86
    max_cpu 86
    gpu 75
    max_gpu 75
    rom 72
    max_rom 72
  ]
  node [
    id 10
    label "10"
    pos 0.014095436304197961
    pos 0.8406051830902863
    cpu 51
    max_cpu 51
    gpu 75
    max_gpu 75
    rom 86
    max_rom 86
  ]
  node [
    id 11
    label "11"
    pos 0.4472639171966313
    pos 0.12715662590303223
    cpu 60
    max_cpu 60
    gpu 77
    max_gpu 77
    rom 57
    max_rom 57
  ]
  node [
    id 12
    label "12"
    pos 0.3629069630418372
    pos 0.4351324095929572
    cpu 93
    max_cpu 93
    gpu 63
    max_gpu 63
    rom 52
    max_rom 52
  ]
  node [
    id 13
    label "13"
    pos 0.5917275657145097
    pos 0.42882645229174965
    cpu 81
    max_cpu 81
    gpu 77
    max_gpu 77
    rom 52
    max_rom 52
  ]
  node [
    id 14
    label "14"
    pos 0.6991366116458448
    pos 0.8915270201066905
    cpu 91
    max_cpu 91
    gpu 68
    max_gpu 68
    rom 99
    max_rom 99
  ]
  node [
    id 15
    label "15"
    pos 0.659375384599921
    pos 0.7988036738134322
    cpu 66
    max_cpu 66
    gpu 85
    max_gpu 85
    rom 51
    max_rom 51
  ]
  node [
    id 16
    label "16"
    pos 0.8982873348678049
    pos 0.8327596837322249
    cpu 87
    max_cpu 87
    gpu 80
    max_gpu 80
    rom 52
    max_rom 52
  ]
  node [
    id 17
    label "17"
    pos 0.7313060071998174
    pos 0.03347552426816036
    cpu 99
    max_cpu 99
    gpu 71
    max_gpu 71
    rom 87
    max_rom 87
  ]
  node [
    id 18
    label "18"
    pos 0.01032786861852919
    pos 0.10534017889287028
    cpu 55
    max_cpu 55
    gpu 66
    max_gpu 66
    rom 99
    max_rom 99
  ]
  node [
    id 19
    label "19"
    pos 0.2114153927509681
    pos 0.7316561938922626
    cpu 81
    max_cpu 81
    gpu 60
    max_gpu 60
    rom 81
    max_rom 81
  ]
  node [
    id 20
    label "20"
    pos 0.4745475614017941
    pos 0.0709423209859491
    cpu 76
    max_cpu 76
    gpu 70
    max_gpu 70
    rom 96
    max_rom 96
  ]
  node [
    id 21
    label "21"
    pos 0.554730285258371
    pos 0.3800877465566783
    cpu 78
    max_cpu 78
    gpu 74
    max_gpu 74
    rom 60
    max_rom 60
  ]
  node [
    id 22
    label "22"
    pos 0.6938024401657635
    pos 0.6797006244654645
    cpu 78
    max_cpu 78
    gpu 70
    max_gpu 70
    rom 96
    max_rom 96
  ]
  node [
    id 23
    label "23"
    pos 0.5567653517061871
    pos 0.9725235348858344
    cpu 98
    max_cpu 98
    gpu 76
    max_gpu 76
    rom 81
    max_rom 81
  ]
  node [
    id 24
    label "24"
    pos 0.2672659938407216
    pos 0.1789269086064833
    cpu 84
    max_cpu 84
    gpu 74
    max_gpu 74
    rom 95
    max_rom 95
  ]
  node [
    id 25
    label "25"
    pos 0.47321618920829556
    pos 0.7052735424464518
    cpu 90
    max_cpu 90
    gpu 77
    max_gpu 77
    rom 92
    max_rom 92
  ]
  node [
    id 26
    label "26"
    pos 0.10426838582123898
    pos 0.33012586360973684
    cpu 96
    max_cpu 96
    gpu 94
    max_gpu 94
    rom 59
    max_rom 59
  ]
  node [
    id 27
    label "27"
    pos 0.28943253412153724
    pos 0.6709381714476147
    cpu 97
    max_cpu 97
    gpu 73
    max_gpu 73
    rom 77
    max_rom 77
  ]
  node [
    id 28
    label "28"
    pos 0.5999721894352357
    pos 0.2428373090593492
    cpu 57
    max_cpu 57
    gpu 53
    max_gpu 53
    rom 77
    max_rom 77
  ]
  node [
    id 29
    label "29"
    pos 0.6785348618147222
    pos 0.37677355049792405
    cpu 63
    max_cpu 63
    gpu 80
    max_gpu 80
    rom 68
    max_rom 68
  ]
  node [
    id 30
    label "30"
    pos 0.781604884800325
    pos 0.6335141741959908
    cpu 96
    max_cpu 96
    gpu 67
    max_gpu 67
    rom 96
    max_rom 96
  ]
  node [
    id 31
    label "31"
    pos 0.6188450002646548
    pos 0.07385843333912989
    cpu 92
    max_cpu 92
    gpu 63
    max_gpu 63
    rom 94
    max_rom 94
  ]
  node [
    id 32
    label "32"
    pos 0.283157859056795
    pos 0.035478503482951895
    cpu 54
    max_cpu 54
    gpu 87
    max_gpu 87
    rom 81
    max_rom 81
  ]
  node [
    id 33
    label "33"
    pos 0.21588652982060397
    pos 0.8909527102839322
    cpu 65
    max_cpu 65
    gpu 50
    max_gpu 50
    rom 97
    max_rom 97
  ]
  node [
    id 34
    label "34"
    pos 0.6237338648258188
    pos 0.6548926235384858
    cpu 95
    max_cpu 95
    gpu 71
    max_gpu 71
    rom 92
    max_rom 92
  ]
  node [
    id 35
    label "35"
    pos 0.5947536839717269
    pos 0.8567097126576853
    cpu 92
    max_cpu 92
    gpu 80
    max_gpu 80
    rom 77
    max_rom 77
  ]
  node [
    id 36
    label "36"
    pos 0.725216701153867
    pos 0.6749550708870677
    cpu 91
    max_cpu 91
    gpu 52
    max_gpu 52
    rom 58
    max_rom 58
  ]
  node [
    id 37
    label "37"
    pos 0.4563801402225255
    pos 0.28741628608677405
    cpu 53
    max_cpu 53
    gpu 78
    max_gpu 78
    rom 95
    max_rom 95
  ]
  node [
    id 38
    label "38"
    pos 0.06314070669580729
    pos 0.21753807691138682
    cpu 84
    max_cpu 84
    gpu 82
    max_gpu 82
    rom 93
    max_rom 93
  ]
  node [
    id 39
    label "39"
    pos 0.006699281012978564
    pos 0.3145236876057803
    cpu 55
    max_cpu 55
    gpu 77
    max_gpu 77
    rom 83
    max_rom 83
  ]
  node [
    id 40
    label "40"
    pos 0.276072055047352
    pos 0.9017667951768031
    cpu 73
    max_cpu 73
    gpu 74
    max_gpu 74
    rom 88
    max_rom 88
  ]
  node [
    id 41
    label "41"
    pos 0.12030946525457487
    pos 0.8652660497402127
    cpu 97
    max_cpu 97
    gpu 67
    max_gpu 67
    rom 77
    max_rom 77
  ]
  node [
    id 42
    label "42"
    pos 0.12512295447563138
    pos 0.8338477268626417
    cpu 70
    max_cpu 70
    gpu 95
    max_gpu 95
    rom 74
    max_rom 74
  ]
  node [
    id 43
    label "43"
    pos 0.004975999424935651
    pos 0.6685001552908661
    cpu 92
    max_cpu 92
    gpu 90
    max_gpu 90
    rom 60
    max_rom 60
  ]
  node [
    id 44
    label "44"
    pos 0.6460574759983801
    pos 0.16315193227324432
    cpu 98
    max_cpu 98
    gpu 85
    max_gpu 85
    rom 85
    max_rom 85
  ]
  node [
    id 45
    label "45"
    pos 0.5900614566429268
    pos 0.032120711488058284
    cpu 93
    max_cpu 93
    gpu 66
    max_gpu 66
    rom 95
    max_rom 95
  ]
  node [
    id 46
    label "46"
    pos 0.4529093621527004
    pos 0.413466336877663
    cpu 60
    max_cpu 60
    gpu 74
    max_gpu 74
    rom 57
    max_rom 57
  ]
  node [
    id 47
    label "47"
    pos 0.8091554877917083
    pos 0.052098711755618754
    cpu 84
    max_cpu 84
    gpu 52
    max_gpu 52
    rom 99
    max_rom 99
  ]
  node [
    id 48
    label "48"
    pos 0.22001386623443897
    pos 0.43060190860317604
    cpu 72
    max_cpu 72
    gpu 86
    max_gpu 86
    rom 64
    max_rom 64
  ]
  node [
    id 49
    label "49"
    pos 0.7843790869690106
    pos 0.7799836856193747
    cpu 63
    max_cpu 63
    gpu 66
    max_gpu 66
    rom 84
    max_rom 84
  ]
  node [
    id 50
    label "50"
    pos 0.06446174868632237
    pos 0.20454316659350058
    cpu 79
    max_cpu 79
    gpu 64
    max_gpu 64
    rom 77
    max_rom 77
  ]
  node [
    id 51
    label "51"
    pos 0.029707234678101324
    pos 0.9659461809473812
    cpu 63
    max_cpu 63
    gpu 50
    max_gpu 50
    rom 83
    max_rom 83
  ]
  node [
    id 52
    label "52"
    pos 0.25956880193722975
    pos 0.8848570149254362
    cpu 95
    max_cpu 95
    gpu 50
    max_gpu 50
    rom 60
    max_rom 60
  ]
  node [
    id 53
    label "53"
    pos 0.11779199496260151
    pos 0.3263691731113866
    cpu 93
    max_cpu 93
    gpu 75
    max_gpu 75
    rom 70
    max_rom 70
  ]
  node [
    id 54
    label "54"
    pos 0.31093546380896353
    pos 0.4874024633955186
    cpu 72
    max_cpu 72
    gpu 60
    max_gpu 60
    rom 89
    max_rom 89
  ]
  node [
    id 55
    label "55"
    pos 0.6461675022478213
    pos 0.7445234597717716
    cpu 98
    max_cpu 98
    gpu 95
    max_gpu 95
    rom 53
    max_rom 53
  ]
  node [
    id 56
    label "56"
    pos 0.9290882057923318
    pos 0.9280894591648182
    cpu 87
    max_cpu 87
    gpu 80
    max_gpu 80
    rom 91
    max_rom 91
  ]
  node [
    id 57
    label "57"
    pos 0.3307907850000308
    pos 0.8545470574829712
    cpu 85
    max_cpu 85
    gpu 55
    max_gpu 55
    rom 61
    max_rom 61
  ]
  node [
    id 58
    label "58"
    pos 0.4524740477079523
    pos 0.5626848463517362
    cpu 56
    max_cpu 56
    gpu 68
    max_gpu 68
    rom 78
    max_rom 78
  ]
  node [
    id 59
    label "59"
    pos 0.2945123060170002
    pos 0.4005390546493073
    cpu 54
    max_cpu 54
    gpu 83
    max_gpu 83
    rom 96
    max_rom 96
  ]
  node [
    id 60
    label "60"
    pos 0.1561545982351651
    pos 0.9252612742423066
    cpu 72
    max_cpu 72
    gpu 81
    max_gpu 81
    rom 76
    max_rom 76
  ]
  node [
    id 61
    label "61"
    pos 0.4144186081909228
    pos 0.66547135709292
    cpu 54
    max_cpu 54
    gpu 67
    max_gpu 67
    rom 59
    max_rom 59
  ]
  node [
    id 62
    label "62"
    pos 0.3420873871217399
    pos 0.6833945259432783
    cpu 91
    max_cpu 91
    gpu 88
    max_gpu 88
    rom 70
    max_rom 70
  ]
  node [
    id 63
    label "63"
    pos 0.4956237927686842
    pos 0.6259245535525143
    cpu 77
    max_cpu 77
    gpu 51
    max_gpu 51
    rom 69
    max_rom 69
  ]
  node [
    id 64
    label "64"
    pos 0.9478307723981799
    pos 0.6250309622194747
    cpu 69
    max_cpu 69
    gpu 92
    max_gpu 92
    rom 81
    max_rom 81
  ]
  node [
    id 65
    label "65"
    pos 0.2528782132027876
    pos 0.9584488111326227
    cpu 54
    max_cpu 54
    gpu 79
    max_gpu 79
    rom 73
    max_rom 73
  ]
  node [
    id 66
    label "66"
    pos 0.3659235995824379
    pos 0.41911759384436187
    cpu 91
    max_cpu 91
    gpu 73
    max_gpu 73
    rom 74
    max_rom 74
  ]
  node [
    id 67
    label "67"
    pos 0.726920870521755
    pos 0.14939701094435065
    cpu 54
    max_cpu 54
    gpu 91
    max_gpu 91
    rom 77
    max_rom 77
  ]
  node [
    id 68
    label "68"
    pos 0.6850639811089146
    pos 0.4910806713481354
    cpu 85
    max_cpu 85
    gpu 57
    max_gpu 57
    rom 84
    max_rom 84
  ]
  node [
    id 69
    label "69"
    pos 0.7017126813408856
    pos 0.12590670358750344
    cpu 75
    max_cpu 75
    gpu 80
    max_gpu 80
    rom 93
    max_rom 93
  ]
  node [
    id 70
    label "70"
    pos 0.5855578631432005
    pos 0.7712649817138199
    cpu 86
    max_cpu 86
    gpu 53
    max_gpu 53
    rom 86
    max_rom 86
  ]
  node [
    id 71
    label "71"
    pos 0.927730664393297
    pos 0.3008795949679661
    cpu 69
    max_cpu 69
    gpu 100
    max_gpu 100
    rom 92
    max_rom 92
  ]
  node [
    id 72
    label "72"
    pos 0.4608308193998788
    pos 0.8246647758970588
    cpu 73
    max_cpu 73
    gpu 81
    max_gpu 81
    rom 80
    max_rom 80
  ]
  node [
    id 73
    label "73"
    pos 0.6717534375598735
    pos 0.9851718376984033
    cpu 60
    max_cpu 60
    gpu 92
    max_gpu 92
    rom 84
    max_rom 84
  ]
  node [
    id 74
    label "74"
    pos 0.6600381093572083
    pos 0.6659040714462795
    cpu 78
    max_cpu 78
    gpu 70
    max_gpu 70
    rom 59
    max_rom 59
  ]
  node [
    id 75
    label "75"
    pos 0.9223275193612595
    pos 0.21614064346700101
    cpu 100
    max_cpu 100
    gpu 52
    max_gpu 52
    rom 64
    max_rom 64
  ]
  node [
    id 76
    label "76"
    pos 0.8346316164570807
    pos 0.7137195212503562
    cpu 51
    max_cpu 51
    gpu 56
    max_gpu 56
    rom 89
    max_rom 89
  ]
  node [
    id 77
    label "77"
    pos 0.04296714088780862
    pos 0.9307320242737426
    cpu 96
    max_cpu 96
    gpu 94
    max_gpu 94
    rom 55
    max_rom 55
  ]
  node [
    id 78
    label "78"
    pos 0.02365715548418268
    pos 0.029281750236232473
    cpu 63
    max_cpu 63
    gpu 90
    max_gpu 90
    rom 50
    max_rom 50
  ]
  node [
    id 79
    label "79"
    pos 0.4975619190527645
    pos 0.25444663975599113
    cpu 57
    max_cpu 57
    gpu 52
    max_gpu 52
    rom 90
    max_rom 90
  ]
  node [
    id 80
    label "80"
    pos 0.5265576003786924
    pos 0.8658212394051801
    cpu 88
    max_cpu 88
    gpu 66
    max_gpu 66
    rom 99
    max_rom 99
  ]
  node [
    id 81
    label "81"
    pos 0.43553611111418666
    pos 0.3158674451658672
    cpu 50
    max_cpu 50
    gpu 87
    max_gpu 87
    rom 61
    max_rom 61
  ]
  node [
    id 82
    label "82"
    pos 0.05127490391897005
    pos 0.27134466166222626
    cpu 55
    max_cpu 55
    gpu 74
    max_gpu 74
    rom 71
    max_rom 71
  ]
  node [
    id 83
    label "83"
    pos 0.3608580717772021
    pos 0.5537096931652046
    cpu 85
    max_cpu 85
    gpu 96
    max_gpu 96
    rom 51
    max_rom 51
  ]
  node [
    id 84
    label "84"
    pos 0.24040615893436423
    pos 0.9384831981575162
    cpu 100
    max_cpu 100
    gpu 92
    max_gpu 92
    rom 81
    max_rom 81
  ]
  node [
    id 85
    label "85"
    pos 0.9938670482637662
    pos 0.86360632706831
    cpu 61
    max_cpu 61
    gpu 71
    max_gpu 71
    rom 81
    max_rom 81
  ]
  node [
    id 86
    label "86"
    pos 0.224874414768662
    pos 0.48838022668391645
    cpu 90
    max_cpu 90
    gpu 74
    max_gpu 74
    rom 55
    max_rom 55
  ]
  node [
    id 87
    label "87"
    pos 0.009921102199206056
    pos 0.5929736883873328
    cpu 60
    max_cpu 60
    gpu 52
    max_gpu 52
    rom 84
    max_rom 84
  ]
  node [
    id 88
    label "88"
    pos 0.8357229228890316
    pos 0.6092399702281948
    cpu 68
    max_cpu 68
    gpu 50
    max_gpu 50
    rom 83
    max_rom 83
  ]
  node [
    id 89
    label "89"
    pos 0.9983472536923983
    pos 0.9762178398713165
    cpu 64
    max_cpu 64
    gpu 82
    max_gpu 82
    rom 55
    max_rom 55
  ]
  node [
    id 90
    label "90"
    pos 0.6758295955741285
    pos 0.6912366590976039
    cpu 59
    max_cpu 59
    gpu 96
    max_gpu 96
    rom 64
    max_rom 64
  ]
  node [
    id 91
    label "91"
    pos 0.11571088082281844
    pos 0.7324511312011922
    cpu 51
    max_cpu 51
    gpu 72
    max_gpu 72
    rom 75
    max_rom 75
  ]
  node [
    id 92
    label "92"
    pos 0.10370540289450514
    pos 0.3779231332155323
    cpu 84
    max_cpu 84
    gpu 56
    max_gpu 56
    rom 64
    max_rom 64
  ]
  node [
    id 93
    label "93"
    pos 0.6294798620187725
    pos 0.5773537760541355
    cpu 98
    max_cpu 98
    gpu 75
    max_gpu 75
    rom 52
    max_rom 52
  ]
  node [
    id 94
    label "94"
    pos 0.8721607364466396
    pos 0.7570610295337855
    cpu 65
    max_cpu 65
    gpu 98
    max_gpu 98
    rom 53
    max_rom 53
  ]
  node [
    id 95
    label "95"
    pos 0.9536611613149195
    pos 0.04263966475080583
    cpu 76
    max_cpu 76
    gpu 56
    max_gpu 56
    rom 96
    max_rom 96
  ]
  node [
    id 96
    label "96"
    pos 0.912556815870915
    pos 0.08336968553145385
    cpu 50
    max_cpu 50
    gpu 59
    max_gpu 59
    rom 69
    max_rom 69
  ]
  node [
    id 97
    label "97"
    pos 0.09276186430928401
    pos 0.01515834918441561
    cpu 61
    max_cpu 61
    gpu 52
    max_gpu 52
    rom 73
    max_rom 73
  ]
  node [
    id 98
    label "98"
    pos 0.6956353199546748
    pos 0.27637708521827187
    cpu 83
    max_cpu 83
    gpu 57
    max_gpu 57
    rom 67
    max_rom 67
  ]
  node [
    id 99
    label "99"
    pos 0.4351411184648546
    pos 0.5927692878903532
    cpu 60
    max_cpu 60
    gpu 65
    max_gpu 65
    rom 96
    max_rom 96
  ]
  edge [
    source 0
    target 3
    bw 83
    max_bw 83
  ]
  edge [
    source 0
    target 4
    bw 67
    max_bw 67
  ]
  edge [
    source 0
    target 11
    bw 53
    max_bw 53
  ]
  edge [
    source 0
    target 12
    bw 68
    max_bw 68
  ]
  edge [
    source 0
    target 16
    bw 93
    max_bw 93
  ]
  edge [
    source 0
    target 20
    bw 99
    max_bw 99
  ]
  edge [
    source 0
    target 21
    bw 52
    max_bw 52
  ]
  edge [
    source 0
    target 27
    bw 82
    max_bw 82
  ]
  edge [
    source 0
    target 40
    bw 88
    max_bw 88
  ]
  edge [
    source 0
    target 44
    bw 52
    max_bw 52
  ]
  edge [
    source 0
    target 45
    bw 55
    max_bw 55
  ]
  edge [
    source 0
    target 59
    bw 98
    max_bw 98
  ]
  edge [
    source 0
    target 68
    bw 77
    max_bw 77
  ]
  edge [
    source 0
    target 69
    bw 89
    max_bw 89
  ]
  edge [
    source 0
    target 71
    bw 98
    max_bw 98
  ]
  edge [
    source 0
    target 82
    bw 91
    max_bw 91
  ]
  edge [
    source 0
    target 99
    bw 52
    max_bw 52
  ]
  edge [
    source 1
    target 6
    bw 52
    max_bw 52
  ]
  edge [
    source 1
    target 12
    bw 71
    max_bw 71
  ]
  edge [
    source 1
    target 38
    bw 78
    max_bw 78
  ]
  edge [
    source 1
    target 39
    bw 92
    max_bw 92
  ]
  edge [
    source 1
    target 40
    bw 89
    max_bw 89
  ]
  edge [
    source 1
    target 43
    bw 59
    max_bw 59
  ]
  edge [
    source 1
    target 48
    bw 60
    max_bw 60
  ]
  edge [
    source 1
    target 54
    bw 75
    max_bw 75
  ]
  edge [
    source 1
    target 61
    bw 84
    max_bw 84
  ]
  edge [
    source 1
    target 62
    bw 71
    max_bw 71
  ]
  edge [
    source 1
    target 77
    bw 87
    max_bw 87
  ]
  edge [
    source 1
    target 78
    bw 84
    max_bw 84
  ]
  edge [
    source 1
    target 86
    bw 90
    max_bw 90
  ]
  edge [
    source 1
    target 92
    bw 74
    max_bw 74
  ]
  edge [
    source 2
    target 22
    bw 60
    max_bw 60
  ]
  edge [
    source 2
    target 31
    bw 93
    max_bw 93
  ]
  edge [
    source 2
    target 34
    bw 72
    max_bw 72
  ]
  edge [
    source 2
    target 48
    bw 52
    max_bw 52
  ]
  edge [
    source 2
    target 52
    bw 84
    max_bw 84
  ]
  edge [
    source 2
    target 64
    bw 81
    max_bw 81
  ]
  edge [
    source 2
    target 68
    bw 51
    max_bw 51
  ]
  edge [
    source 2
    target 79
    bw 72
    max_bw 72
  ]
  edge [
    source 2
    target 86
    bw 82
    max_bw 82
  ]
  edge [
    source 2
    target 88
    bw 56
    max_bw 56
  ]
  edge [
    source 2
    target 94
    bw 100
    max_bw 100
  ]
  edge [
    source 3
    target 4
    bw 78
    max_bw 78
  ]
  edge [
    source 3
    target 10
    bw 75
    max_bw 75
  ]
  edge [
    source 3
    target 13
    bw 57
    max_bw 57
  ]
  edge [
    source 3
    target 14
    bw 89
    max_bw 89
  ]
  edge [
    source 3
    target 15
    bw 98
    max_bw 98
  ]
  edge [
    source 3
    target 28
    bw 62
    max_bw 62
  ]
  edge [
    source 3
    target 38
    bw 88
    max_bw 88
  ]
  edge [
    source 3
    target 45
    bw 62
    max_bw 62
  ]
  edge [
    source 3
    target 49
    bw 72
    max_bw 72
  ]
  edge [
    source 3
    target 54
    bw 72
    max_bw 72
  ]
  edge [
    source 3
    target 58
    bw 75
    max_bw 75
  ]
  edge [
    source 3
    target 69
    bw 78
    max_bw 78
  ]
  edge [
    source 3
    target 91
    bw 69
    max_bw 69
  ]
  edge [
    source 3
    target 92
    bw 99
    max_bw 99
  ]
  edge [
    source 3
    target 97
    bw 54
    max_bw 54
  ]
  edge [
    source 4
    target 21
    bw 74
    max_bw 74
  ]
  edge [
    source 4
    target 59
    bw 63
    max_bw 63
  ]
  edge [
    source 4
    target 63
    bw 61
    max_bw 61
  ]
  edge [
    source 4
    target 67
    bw 95
    max_bw 95
  ]
  edge [
    source 4
    target 76
    bw 78
    max_bw 78
  ]
  edge [
    source 4
    target 79
    bw 92
    max_bw 92
  ]
  edge [
    source 4
    target 99
    bw 85
    max_bw 85
  ]
  edge [
    source 5
    target 15
    bw 58
    max_bw 58
  ]
  edge [
    source 5
    target 22
    bw 70
    max_bw 70
  ]
  edge [
    source 5
    target 34
    bw 87
    max_bw 87
  ]
  edge [
    source 5
    target 35
    bw 86
    max_bw 86
  ]
  edge [
    source 5
    target 55
    bw 87
    max_bw 87
  ]
  edge [
    source 5
    target 61
    bw 100
    max_bw 100
  ]
  edge [
    source 5
    target 69
    bw 61
    max_bw 61
  ]
  edge [
    source 5
    target 71
    bw 61
    max_bw 61
  ]
  edge [
    source 5
    target 72
    bw 59
    max_bw 59
  ]
  edge [
    source 5
    target 76
    bw 70
    max_bw 70
  ]
  edge [
    source 5
    target 85
    bw 100
    max_bw 100
  ]
  edge [
    source 5
    target 88
    bw 51
    max_bw 51
  ]
  edge [
    source 5
    target 90
    bw 96
    max_bw 96
  ]
  edge [
    source 6
    target 10
    bw 79
    max_bw 79
  ]
  edge [
    source 6
    target 11
    bw 68
    max_bw 68
  ]
  edge [
    source 6
    target 41
    bw 86
    max_bw 86
  ]
  edge [
    source 6
    target 48
    bw 96
    max_bw 96
  ]
  edge [
    source 6
    target 54
    bw 77
    max_bw 77
  ]
  edge [
    source 6
    target 59
    bw 76
    max_bw 76
  ]
  edge [
    source 6
    target 60
    bw 72
    max_bw 72
  ]
  edge [
    source 6
    target 85
    bw 75
    max_bw 75
  ]
  edge [
    source 6
    target 86
    bw 84
    max_bw 84
  ]
  edge [
    source 7
    target 15
    bw 83
    max_bw 83
  ]
  edge [
    source 7
    target 23
    bw 69
    max_bw 69
  ]
  edge [
    source 7
    target 34
    bw 53
    max_bw 53
  ]
  edge [
    source 7
    target 38
    bw 97
    max_bw 97
  ]
  edge [
    source 7
    target 55
    bw 99
    max_bw 99
  ]
  edge [
    source 7
    target 59
    bw 58
    max_bw 58
  ]
  edge [
    source 7
    target 63
    bw 88
    max_bw 88
  ]
  edge [
    source 7
    target 64
    bw 75
    max_bw 75
  ]
  edge [
    source 7
    target 67
    bw 57
    max_bw 57
  ]
  edge [
    source 7
    target 72
    bw 92
    max_bw 92
  ]
  edge [
    source 7
    target 74
    bw 71
    max_bw 71
  ]
  edge [
    source 7
    target 80
    bw 69
    max_bw 69
  ]
  edge [
    source 7
    target 85
    bw 71
    max_bw 71
  ]
  edge [
    source 8
    target 17
    bw 68
    max_bw 68
  ]
  edge [
    source 8
    target 21
    bw 73
    max_bw 73
  ]
  edge [
    source 8
    target 28
    bw 68
    max_bw 68
  ]
  edge [
    source 8
    target 29
    bw 96
    max_bw 96
  ]
  edge [
    source 8
    target 31
    bw 73
    max_bw 73
  ]
  edge [
    source 8
    target 32
    bw 100
    max_bw 100
  ]
  edge [
    source 8
    target 45
    bw 79
    max_bw 79
  ]
  edge [
    source 8
    target 46
    bw 62
    max_bw 62
  ]
  edge [
    source 8
    target 67
    bw 50
    max_bw 50
  ]
  edge [
    source 8
    target 75
    bw 52
    max_bw 52
  ]
  edge [
    source 8
    target 76
    bw 84
    max_bw 84
  ]
  edge [
    source 8
    target 90
    bw 92
    max_bw 92
  ]
  edge [
    source 8
    target 94
    bw 92
    max_bw 92
  ]
  edge [
    source 8
    target 97
    bw 72
    max_bw 72
  ]
  edge [
    source 8
    target 98
    bw 93
    max_bw 93
  ]
  edge [
    source 9
    target 47
    bw 81
    max_bw 81
  ]
  edge [
    source 9
    target 50
    bw 80
    max_bw 80
  ]
  edge [
    source 9
    target 67
    bw 78
    max_bw 78
  ]
  edge [
    source 9
    target 96
    bw 88
    max_bw 88
  ]
  edge [
    source 10
    target 27
    bw 66
    max_bw 66
  ]
  edge [
    source 10
    target 34
    bw 77
    max_bw 77
  ]
  edge [
    source 10
    target 40
    bw 71
    max_bw 71
  ]
  edge [
    source 10
    target 43
    bw 64
    max_bw 64
  ]
  edge [
    source 10
    target 57
    bw 89
    max_bw 89
  ]
  edge [
    source 10
    target 62
    bw 75
    max_bw 75
  ]
  edge [
    source 10
    target 86
    bw 79
    max_bw 79
  ]
  edge [
    source 10
    target 87
    bw 59
    max_bw 59
  ]
  edge [
    source 11
    target 18
    bw 54
    max_bw 54
  ]
  edge [
    source 11
    target 20
    bw 81
    max_bw 81
  ]
  edge [
    source 11
    target 26
    bw 99
    max_bw 99
  ]
  edge [
    source 11
    target 31
    bw 70
    max_bw 70
  ]
  edge [
    source 11
    target 37
    bw 57
    max_bw 57
  ]
  edge [
    source 11
    target 40
    bw 76
    max_bw 76
  ]
  edge [
    source 11
    target 57
    bw 84
    max_bw 84
  ]
  edge [
    source 11
    target 63
    bw 89
    max_bw 89
  ]
  edge [
    source 11
    target 81
    bw 75
    max_bw 75
  ]
  edge [
    source 11
    target 82
    bw 51
    max_bw 51
  ]
  edge [
    source 11
    target 87
    bw 62
    max_bw 62
  ]
  edge [
    source 11
    target 98
    bw 82
    max_bw 82
  ]
  edge [
    source 12
    target 25
    bw 93
    max_bw 93
  ]
  edge [
    source 12
    target 27
    bw 73
    max_bw 73
  ]
  edge [
    source 12
    target 39
    bw 79
    max_bw 79
  ]
  edge [
    source 12
    target 41
    bw 55
    max_bw 55
  ]
  edge [
    source 12
    target 46
    bw 71
    max_bw 71
  ]
  edge [
    source 12
    target 48
    bw 77
    max_bw 77
  ]
  edge [
    source 12
    target 52
    bw 54
    max_bw 54
  ]
  edge [
    source 12
    target 53
    bw 51
    max_bw 51
  ]
  edge [
    source 12
    target 62
    bw 52
    max_bw 52
  ]
  edge [
    source 12
    target 66
    bw 88
    max_bw 88
  ]
  edge [
    source 12
    target 69
    bw 78
    max_bw 78
  ]
  edge [
    source 12
    target 74
    bw 70
    max_bw 70
  ]
  edge [
    source 12
    target 78
    bw 91
    max_bw 91
  ]
  edge [
    source 12
    target 81
    bw 66
    max_bw 66
  ]
  edge [
    source 12
    target 99
    bw 63
    max_bw 63
  ]
  edge [
    source 13
    target 17
    bw 79
    max_bw 79
  ]
  edge [
    source 13
    target 18
    bw 60
    max_bw 60
  ]
  edge [
    source 13
    target 24
    bw 84
    max_bw 84
  ]
  edge [
    source 13
    target 28
    bw 78
    max_bw 78
  ]
  edge [
    source 13
    target 47
    bw 91
    max_bw 91
  ]
  edge [
    source 13
    target 52
    bw 80
    max_bw 80
  ]
  edge [
    source 13
    target 61
    bw 69
    max_bw 69
  ]
  edge [
    source 13
    target 63
    bw 58
    max_bw 58
  ]
  edge [
    source 13
    target 70
    bw 71
    max_bw 71
  ]
  edge [
    source 13
    target 71
    bw 72
    max_bw 72
  ]
  edge [
    source 13
    target 83
    bw 94
    max_bw 94
  ]
  edge [
    source 13
    target 86
    bw 68
    max_bw 68
  ]
  edge [
    source 14
    target 16
    bw 84
    max_bw 84
  ]
  edge [
    source 14
    target 19
    bw 69
    max_bw 69
  ]
  edge [
    source 14
    target 22
    bw 65
    max_bw 65
  ]
  edge [
    source 14
    target 30
    bw 98
    max_bw 98
  ]
  edge [
    source 14
    target 34
    bw 76
    max_bw 76
  ]
  edge [
    source 14
    target 35
    bw 81
    max_bw 81
  ]
  edge [
    source 14
    target 38
    bw 89
    max_bw 89
  ]
  edge [
    source 14
    target 68
    bw 61
    max_bw 61
  ]
  edge [
    source 14
    target 73
    bw 96
    max_bw 96
  ]
  edge [
    source 14
    target 88
    bw 92
    max_bw 92
  ]
  edge [
    source 14
    target 89
    bw 89
    max_bw 89
  ]
  edge [
    source 15
    target 34
    bw 72
    max_bw 72
  ]
  edge [
    source 15
    target 35
    bw 94
    max_bw 94
  ]
  edge [
    source 15
    target 36
    bw 77
    max_bw 77
  ]
  edge [
    source 15
    target 66
    bw 96
    max_bw 96
  ]
  edge [
    source 15
    target 68
    bw 59
    max_bw 59
  ]
  edge [
    source 15
    target 69
    bw 64
    max_bw 64
  ]
  edge [
    source 15
    target 74
    bw 75
    max_bw 75
  ]
  edge [
    source 15
    target 79
    bw 67
    max_bw 67
  ]
  edge [
    source 15
    target 88
    bw 76
    max_bw 76
  ]
  edge [
    source 16
    target 33
    bw 70
    max_bw 70
  ]
  edge [
    source 16
    target 49
    bw 88
    max_bw 88
  ]
  edge [
    source 16
    target 70
    bw 94
    max_bw 94
  ]
  edge [
    source 16
    target 73
    bw 81
    max_bw 81
  ]
  edge [
    source 16
    target 75
    bw 100
    max_bw 100
  ]
  edge [
    source 16
    target 76
    bw 61
    max_bw 61
  ]
  edge [
    source 16
    target 80
    bw 63
    max_bw 63
  ]
  edge [
    source 16
    target 85
    bw 95
    max_bw 95
  ]
  edge [
    source 16
    target 90
    bw 56
    max_bw 56
  ]
  edge [
    source 16
    target 94
    bw 68
    max_bw 68
  ]
  edge [
    source 17
    target 30
    bw 88
    max_bw 88
  ]
  edge [
    source 17
    target 68
    bw 91
    max_bw 91
  ]
  edge [
    source 17
    target 69
    bw 56
    max_bw 56
  ]
  edge [
    source 17
    target 76
    bw 71
    max_bw 71
  ]
  edge [
    source 17
    target 95
    bw 87
    max_bw 87
  ]
  edge [
    source 18
    target 32
    bw 77
    max_bw 77
  ]
  edge [
    source 18
    target 39
    bw 86
    max_bw 86
  ]
  edge [
    source 18
    target 46
    bw 87
    max_bw 87
  ]
  edge [
    source 18
    target 50
    bw 100
    max_bw 100
  ]
  edge [
    source 18
    target 53
    bw 87
    max_bw 87
  ]
  edge [
    source 18
    target 59
    bw 79
    max_bw 79
  ]
  edge [
    source 18
    target 78
    bw 58
    max_bw 58
  ]
  edge [
    source 19
    target 43
    bw 98
    max_bw 98
  ]
  edge [
    source 19
    target 52
    bw 76
    max_bw 76
  ]
  edge [
    source 19
    target 65
    bw 91
    max_bw 91
  ]
  edge [
    source 19
    target 74
    bw 77
    max_bw 77
  ]
  edge [
    source 19
    target 91
    bw 71
    max_bw 71
  ]
  edge [
    source 20
    target 24
    bw 78
    max_bw 78
  ]
  edge [
    source 20
    target 53
    bw 55
    max_bw 55
  ]
  edge [
    source 20
    target 59
    bw 53
    max_bw 53
  ]
  edge [
    source 20
    target 66
    bw 55
    max_bw 55
  ]
  edge [
    source 20
    target 67
    bw 86
    max_bw 86
  ]
  edge [
    source 20
    target 79
    bw 63
    max_bw 63
  ]
  edge [
    source 20
    target 87
    bw 52
    max_bw 52
  ]
  edge [
    source 21
    target 22
    bw 91
    max_bw 91
  ]
  edge [
    source 21
    target 35
    bw 71
    max_bw 71
  ]
  edge [
    source 21
    target 58
    bw 75
    max_bw 75
  ]
  edge [
    source 21
    target 62
    bw 96
    max_bw 96
  ]
  edge [
    source 21
    target 63
    bw 51
    max_bw 51
  ]
  edge [
    source 21
    target 69
    bw 62
    max_bw 62
  ]
  edge [
    source 21
    target 71
    bw 94
    max_bw 94
  ]
  edge [
    source 21
    target 83
    bw 93
    max_bw 93
  ]
  edge [
    source 22
    target 35
    bw 82
    max_bw 82
  ]
  edge [
    source 22
    target 36
    bw 74
    max_bw 74
  ]
  edge [
    source 22
    target 39
    bw 97
    max_bw 97
  ]
  edge [
    source 22
    target 43
    bw 71
    max_bw 71
  ]
  edge [
    source 22
    target 52
    bw 77
    max_bw 77
  ]
  edge [
    source 22
    target 59
    bw 99
    max_bw 99
  ]
  edge [
    source 22
    target 76
    bw 97
    max_bw 97
  ]
  edge [
    source 22
    target 79
    bw 94
    max_bw 94
  ]
  edge [
    source 22
    target 82
    bw 85
    max_bw 85
  ]
  edge [
    source 22
    target 90
    bw 61
    max_bw 61
  ]
  edge [
    source 22
    target 98
    bw 87
    max_bw 87
  ]
  edge [
    source 23
    target 26
    bw 50
    max_bw 50
  ]
  edge [
    source 23
    target 48
    bw 57
    max_bw 57
  ]
  edge [
    source 23
    target 60
    bw 84
    max_bw 84
  ]
  edge [
    source 23
    target 62
    bw 77
    max_bw 77
  ]
  edge [
    source 23
    target 70
    bw 93
    max_bw 93
  ]
  edge [
    source 23
    target 94
    bw 88
    max_bw 88
  ]
  edge [
    source 24
    target 39
    bw 71
    max_bw 71
  ]
  edge [
    source 24
    target 43
    bw 83
    max_bw 83
  ]
  edge [
    source 24
    target 44
    bw 82
    max_bw 82
  ]
  edge [
    source 24
    target 46
    bw 71
    max_bw 71
  ]
  edge [
    source 24
    target 50
    bw 77
    max_bw 77
  ]
  edge [
    source 24
    target 83
    bw 82
    max_bw 82
  ]
  edge [
    source 24
    target 86
    bw 56
    max_bw 56
  ]
  edge [
    source 24
    target 91
    bw 86
    max_bw 86
  ]
  edge [
    source 24
    target 96
    bw 83
    max_bw 83
  ]
  edge [
    source 25
    target 33
    bw 94
    max_bw 94
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
    bw 68
    max_bw 68
  ]
  edge [
    source 25
    target 40
    bw 94
    max_bw 94
  ]
  edge [
    source 25
    target 46
    bw 76
    max_bw 76
  ]
  edge [
    source 25
    target 50
    bw 57
    max_bw 57
  ]
  edge [
    source 25
    target 54
    bw 60
    max_bw 60
  ]
  edge [
    source 25
    target 72
    bw 91
    max_bw 91
  ]
  edge [
    source 26
    target 38
    bw 59
    max_bw 59
  ]
  edge [
    source 26
    target 48
    bw 89
    max_bw 89
  ]
  edge [
    source 26
    target 69
    bw 66
    max_bw 66
  ]
  edge [
    source 26
    target 86
    bw 93
    max_bw 93
  ]
  edge [
    source 27
    target 33
    bw 70
    max_bw 70
  ]
  edge [
    source 27
    target 36
    bw 59
    max_bw 59
  ]
  edge [
    source 27
    target 40
    bw 59
    max_bw 59
  ]
  edge [
    source 27
    target 41
    bw 58
    max_bw 58
  ]
  edge [
    source 27
    target 43
    bw 87
    max_bw 87
  ]
  edge [
    source 27
    target 45
    bw 51
    max_bw 51
  ]
  edge [
    source 27
    target 48
    bw 89
    max_bw 89
  ]
  edge [
    source 27
    target 52
    bw 100
    max_bw 100
  ]
  edge [
    source 27
    target 54
    bw 53
    max_bw 53
  ]
  edge [
    source 27
    target 68
    bw 79
    max_bw 79
  ]
  edge [
    source 27
    target 70
    bw 60
    max_bw 60
  ]
  edge [
    source 27
    target 88
    bw 65
    max_bw 65
  ]
  edge [
    source 28
    target 30
    bw 52
    max_bw 52
  ]
  edge [
    source 28
    target 34
    bw 76
    max_bw 76
  ]
  edge [
    source 28
    target 44
    bw 84
    max_bw 84
  ]
  edge [
    source 28
    target 45
    bw 63
    max_bw 63
  ]
  edge [
    source 28
    target 47
    bw 62
    max_bw 62
  ]
  edge [
    source 28
    target 49
    bw 51
    max_bw 51
  ]
  edge [
    source 29
    target 44
    bw 96
    max_bw 96
  ]
  edge [
    source 29
    target 45
    bw 87
    max_bw 87
  ]
  edge [
    source 29
    target 58
    bw 50
    max_bw 50
  ]
  edge [
    source 29
    target 61
    bw 57
    max_bw 57
  ]
  edge [
    source 29
    target 75
    bw 56
    max_bw 56
  ]
  edge [
    source 29
    target 77
    bw 57
    max_bw 57
  ]
  edge [
    source 29
    target 79
    bw 50
    max_bw 50
  ]
  edge [
    source 29
    target 94
    bw 66
    max_bw 66
  ]
  edge [
    source 29
    target 95
    bw 60
    max_bw 60
  ]
  edge [
    source 30
    target 47
    bw 90
    max_bw 90
  ]
  edge [
    source 30
    target 49
    bw 94
    max_bw 94
  ]
  edge [
    source 30
    target 60
    bw 83
    max_bw 83
  ]
  edge [
    source 30
    target 63
    bw 80
    max_bw 80
  ]
  edge [
    source 30
    target 64
    bw 86
    max_bw 86
  ]
  edge [
    source 30
    target 74
    bw 69
    max_bw 69
  ]
  edge [
    source 30
    target 83
    bw 55
    max_bw 55
  ]
  edge [
    source 30
    target 94
    bw 94
    max_bw 94
  ]
  edge [
    source 31
    target 32
    bw 86
    max_bw 86
  ]
  edge [
    source 31
    target 37
    bw 73
    max_bw 73
  ]
  edge [
    source 31
    target 44
    bw 95
    max_bw 95
  ]
  edge [
    source 31
    target 69
    bw 94
    max_bw 94
  ]
  edge [
    source 31
    target 79
    bw 70
    max_bw 70
  ]
  edge [
    source 31
    target 81
    bw 51
    max_bw 51
  ]
  edge [
    source 32
    target 33
    bw 54
    max_bw 54
  ]
  edge [
    source 32
    target 39
    bw 66
    max_bw 66
  ]
  edge [
    source 32
    target 40
    bw 54
    max_bw 54
  ]
  edge [
    source 32
    target 64
    bw 98
    max_bw 98
  ]
  edge [
    source 32
    target 83
    bw 71
    max_bw 71
  ]
  edge [
    source 32
    target 96
    bw 59
    max_bw 59
  ]
  edge [
    source 32
    target 98
    bw 50
    max_bw 50
  ]
  edge [
    source 33
    target 34
    bw 99
    max_bw 99
  ]
  edge [
    source 33
    target 35
    bw 69
    max_bw 69
  ]
  edge [
    source 33
    target 41
    bw 61
    max_bw 61
  ]
  edge [
    source 33
    target 52
    bw 51
    max_bw 51
  ]
  edge [
    source 33
    target 57
    bw 90
    max_bw 90
  ]
  edge [
    source 33
    target 66
    bw 58
    max_bw 58
  ]
  edge [
    source 33
    target 92
    bw 92
    max_bw 92
  ]
  edge [
    source 34
    target 41
    bw 82
    max_bw 82
  ]
  edge [
    source 34
    target 49
    bw 61
    max_bw 61
  ]
  edge [
    source 34
    target 53
    bw 56
    max_bw 56
  ]
  edge [
    source 34
    target 57
    bw 72
    max_bw 72
  ]
  edge [
    source 34
    target 58
    bw 68
    max_bw 68
  ]
  edge [
    source 34
    target 63
    bw 87
    max_bw 87
  ]
  edge [
    source 34
    target 72
    bw 80
    max_bw 80
  ]
  edge [
    source 34
    target 85
    bw 71
    max_bw 71
  ]
  edge [
    source 34
    target 88
    bw 50
    max_bw 50
  ]
  edge [
    source 34
    target 90
    bw 53
    max_bw 53
  ]
  edge [
    source 34
    target 99
    bw 88
    max_bw 88
  ]
  edge [
    source 35
    target 80
    bw 74
    max_bw 74
  ]
  edge [
    source 35
    target 89
    bw 86
    max_bw 86
  ]
  edge [
    source 35
    target 92
    bw 96
    max_bw 96
  ]
  edge [
    source 36
    target 37
    bw 69
    max_bw 69
  ]
  edge [
    source 36
    target 48
    bw 95
    max_bw 95
  ]
  edge [
    source 36
    target 61
    bw 71
    max_bw 71
  ]
  edge [
    source 36
    target 68
    bw 89
    max_bw 89
  ]
  edge [
    source 36
    target 73
    bw 81
    max_bw 81
  ]
  edge [
    source 36
    target 74
    bw 76
    max_bw 76
  ]
  edge [
    source 36
    target 78
    bw 61
    max_bw 61
  ]
  edge [
    source 36
    target 79
    bw 79
    max_bw 79
  ]
  edge [
    source 36
    target 81
    bw 83
    max_bw 83
  ]
  edge [
    source 36
    target 88
    bw 79
    max_bw 79
  ]
  edge [
    source 36
    target 90
    bw 60
    max_bw 60
  ]
  edge [
    source 36
    target 93
    bw 87
    max_bw 87
  ]
  edge [
    source 36
    target 99
    bw 92
    max_bw 92
  ]
  edge [
    source 37
    target 44
    bw 99
    max_bw 99
  ]
  edge [
    source 37
    target 83
    bw 81
    max_bw 81
  ]
  edge [
    source 38
    target 39
    bw 71
    max_bw 71
  ]
  edge [
    source 38
    target 41
    bw 68
    max_bw 68
  ]
  edge [
    source 38
    target 50
    bw 96
    max_bw 96
  ]
  edge [
    source 38
    target 53
    bw 70
    max_bw 70
  ]
  edge [
    source 38
    target 66
    bw 100
    max_bw 100
  ]
  edge [
    source 38
    target 82
    bw 72
    max_bw 72
  ]
  edge [
    source 39
    target 46
    bw 52
    max_bw 52
  ]
  edge [
    source 39
    target 50
    bw 74
    max_bw 74
  ]
  edge [
    source 39
    target 82
    bw 80
    max_bw 80
  ]
  edge [
    source 39
    target 87
    bw 87
    max_bw 87
  ]
  edge [
    source 39
    target 91
    bw 100
    max_bw 100
  ]
  edge [
    source 39
    target 97
    bw 91
    max_bw 91
  ]
  edge [
    source 40
    target 41
    bw 62
    max_bw 62
  ]
  edge [
    source 40
    target 51
    bw 66
    max_bw 66
  ]
  edge [
    source 40
    target 52
    bw 82
    max_bw 82
  ]
  edge [
    source 40
    target 57
    bw 98
    max_bw 98
  ]
  edge [
    source 40
    target 65
    bw 60
    max_bw 60
  ]
  edge [
    source 40
    target 70
    bw 86
    max_bw 86
  ]
  edge [
    source 40
    target 77
    bw 53
    max_bw 53
  ]
  edge [
    source 41
    target 51
    bw 69
    max_bw 69
  ]
  edge [
    source 41
    target 73
    bw 74
    max_bw 74
  ]
  edge [
    source 41
    target 87
    bw 92
    max_bw 92
  ]
  edge [
    source 42
    target 46
    bw 52
    max_bw 52
  ]
  edge [
    source 42
    target 47
    bw 93
    max_bw 93
  ]
  edge [
    source 42
    target 55
    bw 89
    max_bw 89
  ]
  edge [
    source 42
    target 57
    bw 66
    max_bw 66
  ]
  edge [
    source 42
    target 77
    bw 67
    max_bw 67
  ]
  edge [
    source 42
    target 80
    bw 62
    max_bw 62
  ]
  edge [
    source 42
    target 86
    bw 96
    max_bw 96
  ]
  edge [
    source 42
    target 99
    bw 68
    max_bw 68
  ]
  edge [
    source 43
    target 62
    bw 72
    max_bw 72
  ]
  edge [
    source 43
    target 84
    bw 95
    max_bw 95
  ]
  edge [
    source 43
    target 86
    bw 74
    max_bw 74
  ]
  edge [
    source 43
    target 91
    bw 53
    max_bw 53
  ]
  edge [
    source 44
    target 45
    bw 60
    max_bw 60
  ]
  edge [
    source 44
    target 67
    bw 54
    max_bw 54
  ]
  edge [
    source 44
    target 69
    bw 74
    max_bw 74
  ]
  edge [
    source 44
    target 83
    bw 54
    max_bw 54
  ]
  edge [
    source 44
    target 88
    bw 53
    max_bw 53
  ]
  edge [
    source 44
    target 92
    bw 65
    max_bw 65
  ]
  edge [
    source 45
    target 50
    bw 58
    max_bw 58
  ]
  edge [
    source 45
    target 69
    bw 61
    max_bw 61
  ]
  edge [
    source 45
    target 88
    bw 95
    max_bw 95
  ]
  edge [
    source 45
    target 97
    bw 59
    max_bw 59
  ]
  edge [
    source 46
    target 49
    bw 59
    max_bw 59
  ]
  edge [
    source 46
    target 59
    bw 57
    max_bw 57
  ]
  edge [
    source 46
    target 66
    bw 79
    max_bw 79
  ]
  edge [
    source 46
    target 79
    bw 58
    max_bw 58
  ]
  edge [
    source 46
    target 83
    bw 53
    max_bw 53
  ]
  edge [
    source 46
    target 85
    bw 90
    max_bw 90
  ]
  edge [
    source 46
    target 90
    bw 84
    max_bw 84
  ]
  edge [
    source 47
    target 67
    bw 56
    max_bw 56
  ]
  edge [
    source 47
    target 75
    bw 64
    max_bw 64
  ]
  edge [
    source 47
    target 88
    bw 73
    max_bw 73
  ]
  edge [
    source 48
    target 54
    bw 91
    max_bw 91
  ]
  edge [
    source 48
    target 58
    bw 66
    max_bw 66
  ]
  edge [
    source 48
    target 59
    bw 52
    max_bw 52
  ]
  edge [
    source 48
    target 69
    bw 75
    max_bw 75
  ]
  edge [
    source 48
    target 83
    bw 97
    max_bw 97
  ]
  edge [
    source 48
    target 92
    bw 60
    max_bw 60
  ]
  edge [
    source 48
    target 99
    bw 60
    max_bw 60
  ]
  edge [
    source 49
    target 55
    bw 56
    max_bw 56
  ]
  edge [
    source 49
    target 60
    bw 60
    max_bw 60
  ]
  edge [
    source 49
    target 74
    bw 61
    max_bw 61
  ]
  edge [
    source 49
    target 88
    bw 54
    max_bw 54
  ]
  edge [
    source 49
    target 89
    bw 79
    max_bw 79
  ]
  edge [
    source 50
    target 54
    bw 88
    max_bw 88
  ]
  edge [
    source 50
    target 59
    bw 59
    max_bw 59
  ]
  edge [
    source 50
    target 80
    bw 91
    max_bw 91
  ]
  edge [
    source 51
    target 84
    bw 58
    max_bw 58
  ]
  edge [
    source 52
    target 70
    bw 90
    max_bw 90
  ]
  edge [
    source 52
    target 72
    bw 97
    max_bw 97
  ]
  edge [
    source 52
    target 86
    bw 81
    max_bw 81
  ]
  edge [
    source 52
    target 90
    bw 90
    max_bw 90
  ]
  edge [
    source 52
    target 91
    bw 86
    max_bw 86
  ]
  edge [
    source 52
    target 99
    bw 87
    max_bw 87
  ]
  edge [
    source 53
    target 70
    bw 82
    max_bw 82
  ]
  edge [
    source 53
    target 72
    bw 59
    max_bw 59
  ]
  edge [
    source 53
    target 86
    bw 95
    max_bw 95
  ]
  edge [
    source 53
    target 87
    bw 53
    max_bw 53
  ]
  edge [
    source 54
    target 59
    bw 69
    max_bw 69
  ]
  edge [
    source 54
    target 83
    bw 94
    max_bw 94
  ]
  edge [
    source 54
    target 87
    bw 89
    max_bw 89
  ]
  edge [
    source 54
    target 93
    bw 63
    max_bw 63
  ]
  edge [
    source 54
    target 97
    bw 63
    max_bw 63
  ]
  edge [
    source 55
    target 57
    bw 99
    max_bw 99
  ]
  edge [
    source 55
    target 62
    bw 94
    max_bw 94
  ]
  edge [
    source 55
    target 63
    bw 52
    max_bw 52
  ]
  edge [
    source 55
    target 74
    bw 50
    max_bw 50
  ]
  edge [
    source 55
    target 80
    bw 69
    max_bw 69
  ]
  edge [
    source 55
    target 86
    bw 91
    max_bw 91
  ]
  edge [
    source 55
    target 87
    bw 69
    max_bw 69
  ]
  edge [
    source 55
    target 90
    bw 85
    max_bw 85
  ]
  edge [
    source 56
    target 73
    bw 87
    max_bw 87
  ]
  edge [
    source 56
    target 80
    bw 65
    max_bw 65
  ]
  edge [
    source 56
    target 85
    bw 93
    max_bw 93
  ]
  edge [
    source 56
    target 90
    bw 82
    max_bw 82
  ]
  edge [
    source 57
    target 65
    bw 83
    max_bw 83
  ]
  edge [
    source 57
    target 80
    bw 95
    max_bw 95
  ]
  edge [
    source 57
    target 83
    bw 66
    max_bw 66
  ]
  edge [
    source 57
    target 93
    bw 52
    max_bw 52
  ]
  edge [
    source 57
    target 99
    bw 93
    max_bw 93
  ]
  edge [
    source 58
    target 62
    bw 72
    max_bw 72
  ]
  edge [
    source 58
    target 63
    bw 71
    max_bw 71
  ]
  edge [
    source 58
    target 66
    bw 93
    max_bw 93
  ]
  edge [
    source 58
    target 80
    bw 94
    max_bw 94
  ]
  edge [
    source 59
    target 62
    bw 83
    max_bw 83
  ]
  edge [
    source 59
    target 70
    bw 68
    max_bw 68
  ]
  edge [
    source 59
    target 81
    bw 70
    max_bw 70
  ]
  edge [
    source 59
    target 82
    bw 69
    max_bw 69
  ]
  edge [
    source 59
    target 83
    bw 58
    max_bw 58
  ]
  edge [
    source 59
    target 92
    bw 54
    max_bw 54
  ]
  edge [
    source 60
    target 63
    bw 63
    max_bw 63
  ]
  edge [
    source 60
    target 70
    bw 83
    max_bw 83
  ]
  edge [
    source 60
    target 73
    bw 91
    max_bw 91
  ]
  edge [
    source 60
    target 77
    bw 51
    max_bw 51
  ]
  edge [
    source 60
    target 83
    bw 89
    max_bw 89
  ]
  edge [
    source 60
    target 91
    bw 72
    max_bw 72
  ]
  edge [
    source 60
    target 92
    bw 97
    max_bw 97
  ]
  edge [
    source 61
    target 63
    bw 70
    max_bw 70
  ]
  edge [
    source 61
    target 80
    bw 66
    max_bw 66
  ]
  edge [
    source 61
    target 86
    bw 56
    max_bw 56
  ]
  edge [
    source 61
    target 87
    bw 70
    max_bw 70
  ]
  edge [
    source 62
    target 63
    bw 77
    max_bw 77
  ]
  edge [
    source 62
    target 73
    bw 64
    max_bw 64
  ]
  edge [
    source 62
    target 80
    bw 100
    max_bw 100
  ]
  edge [
    source 62
    target 86
    bw 87
    max_bw 87
  ]
  edge [
    source 62
    target 88
    bw 81
    max_bw 81
  ]
  edge [
    source 62
    target 99
    bw 87
    max_bw 87
  ]
  edge [
    source 63
    target 70
    bw 99
    max_bw 99
  ]
  edge [
    source 63
    target 83
    bw 95
    max_bw 95
  ]
  edge [
    source 64
    target 69
    bw 94
    max_bw 94
  ]
  edge [
    source 64
    target 85
    bw 87
    max_bw 87
  ]
  edge [
    source 64
    target 88
    bw 72
    max_bw 72
  ]
  edge [
    source 64
    target 94
    bw 87
    max_bw 87
  ]
  edge [
    source 65
    target 70
    bw 95
    max_bw 95
  ]
  edge [
    source 65
    target 72
    bw 78
    max_bw 78
  ]
  edge [
    source 65
    target 76
    bw 71
    max_bw 71
  ]
  edge [
    source 65
    target 77
    bw 56
    max_bw 56
  ]
  edge [
    source 65
    target 80
    bw 91
    max_bw 91
  ]
  edge [
    source 66
    target 67
    bw 54
    max_bw 54
  ]
  edge [
    source 66
    target 71
    bw 60
    max_bw 60
  ]
  edge [
    source 66
    target 79
    bw 98
    max_bw 98
  ]
  edge [
    source 66
    target 83
    bw 59
    max_bw 59
  ]
  edge [
    source 66
    target 90
    bw 94
    max_bw 94
  ]
  edge [
    source 67
    target 69
    bw 85
    max_bw 85
  ]
  edge [
    source 67
    target 75
    bw 85
    max_bw 85
  ]
  edge [
    source 68
    target 71
    bw 72
    max_bw 72
  ]
  edge [
    source 68
    target 74
    bw 97
    max_bw 97
  ]
  edge [
    source 68
    target 75
    bw 71
    max_bw 71
  ]
  edge [
    source 68
    target 81
    bw 99
    max_bw 99
  ]
  edge [
    source 68
    target 86
    bw 53
    max_bw 53
  ]
  edge [
    source 68
    target 90
    bw 84
    max_bw 84
  ]
  edge [
    source 68
    target 91
    bw 75
    max_bw 75
  ]
  edge [
    source 68
    target 96
    bw 66
    max_bw 66
  ]
  edge [
    source 69
    target 75
    bw 69
    max_bw 69
  ]
  edge [
    source 69
    target 95
    bw 70
    max_bw 70
  ]
  edge [
    source 69
    target 97
    bw 51
    max_bw 51
  ]
  edge [
    source 70
    target 72
    bw 79
    max_bw 79
  ]
  edge [
    source 70
    target 74
    bw 92
    max_bw 92
  ]
  edge [
    source 70
    target 76
    bw 92
    max_bw 92
  ]
  edge [
    source 70
    target 79
    bw 86
    max_bw 86
  ]
  edge [
    source 70
    target 80
    bw 80
    max_bw 80
  ]
  edge [
    source 70
    target 83
    bw 74
    max_bw 74
  ]
  edge [
    source 70
    target 84
    bw 78
    max_bw 78
  ]
  edge [
    source 70
    target 94
    bw 58
    max_bw 58
  ]
  edge [
    source 72
    target 73
    bw 51
    max_bw 51
  ]
  edge [
    source 72
    target 76
    bw 92
    max_bw 92
  ]
  edge [
    source 72
    target 83
    bw 58
    max_bw 58
  ]
  edge [
    source 73
    target 87
    bw 88
    max_bw 88
  ]
  edge [
    source 74
    target 76
    bw 86
    max_bw 86
  ]
  edge [
    source 74
    target 90
    bw 52
    max_bw 52
  ]
  edge [
    source 74
    target 96
    bw 72
    max_bw 72
  ]
  edge [
    source 76
    target 89
    bw 58
    max_bw 58
  ]
  edge [
    source 76
    target 93
    bw 55
    max_bw 55
  ]
  edge [
    source 76
    target 94
    bw 63
    max_bw 63
  ]
  edge [
    source 76
    target 96
    bw 92
    max_bw 92
  ]
  edge [
    source 77
    target 91
    bw 88
    max_bw 88
  ]
  edge [
    source 80
    target 83
    bw 81
    max_bw 81
  ]
  edge [
    source 80
    target 89
    bw 63
    max_bw 63
  ]
  edge [
    source 80
    target 98
    bw 72
    max_bw 72
  ]
  edge [
    source 80
    target 99
    bw 94
    max_bw 94
  ]
  edge [
    source 81
    target 99
    bw 64
    max_bw 64
  ]
  edge [
    source 82
    target 83
    bw 52
    max_bw 52
  ]
  edge [
    source 82
    target 92
    bw 69
    max_bw 69
  ]
  edge [
    source 83
    target 90
    bw 100
    max_bw 100
  ]
  edge [
    source 83
    target 91
    bw 63
    max_bw 63
  ]
  edge [
    source 86
    target 91
    bw 63
    max_bw 63
  ]
  edge [
    source 86
    target 92
    bw 99
    max_bw 99
  ]
  edge [
    source 86
    target 98
    bw 54
    max_bw 54
  ]
  edge [
    source 88
    target 89
    bw 90
    max_bw 90
  ]
  edge [
    source 88
    target 93
    bw 71
    max_bw 71
  ]
  edge [
    source 88
    target 94
    bw 54
    max_bw 54
  ]
  edge [
    source 88
    target 98
    bw 67
    max_bw 67
  ]
  edge [
    source 91
    target 99
    bw 90
    max_bw 90
  ]
  edge [
    source 93
    target 99
    bw 92
    max_bw 92
  ]
  edge [
    source 94
    target 98
    bw 90
    max_bw 90
  ]
  edge [
    source 97
    target 99
    bw 95
    max_bw 95
  ]
]
