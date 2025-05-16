graph [
  node_attrs_setting [
    name "cpu"
    type "resource"
    owner "node"
    distribution "uniform"
    dtype "int"
    generative "True"
    high "100"
    low "50"
  ]
  node_attrs_setting [
    name "max_cpu"
    type "extrema"
    owner "node"
    originator "cpu"
  ]
  link_attrs_setting [
    name "bw"
    type "resource"
    owner "link"
    distribution "uniform"
    dtype "int"
    generative "True"
    high "100"
    low "50"
  ]
  link_attrs_setting [
    name "max_bw"
    type "extrema"
    owner "link"
    originator "bw"
  ]
  topology_num_nodes "20"
  topology_type "waxman"
  topology_wm_alpha "0.5"
  topology_wm_beta "0.2"
  output_save_dir "dataset/p_net"
  output_file_name "p_net.gml"
  node [
    id 0
    label "0"
    pos 0.6588125426177821
    pos 0.5485726830043705
    cpu 61
    max_cpu 61
  ]
  node [
    id 1
    label "1"
    pos 0.843545123386085
    pos 0.005013156266284513
    cpu 61
    max_cpu 61
  ]
  node [
    id 2
    label "2"
    pos 0.5919419818810197
    pos 0.7254711434376944
    cpu 76
    max_cpu 76
  ]
  node [
    id 3
    label "3"
    pos 0.6730424921316871
    pos 0.5105484150114016
    cpu 83
    max_cpu 83
  ]
  node [
    id 4
    label "4"
    pos 0.5071495090694431
    pos 0.3127519042640241
    cpu 52
    max_cpu 52
  ]
  node [
    id 5
    label "5"
    pos 0.06558446822248376
    pos 0.854315513963701
    cpu 73
    max_cpu 73
  ]
  node [
    id 6
    label "6"
    pos 0.8477229221906466
    pos 0.48680911166587626
    cpu 97
    max_cpu 97
  ]
  node [
    id 7
    label "7"
    pos 0.5441224720395809
    pos 0.36015025118153565
    cpu 72
    max_cpu 72
  ]
  node [
    id 8
    label "8"
    pos 0.3543541585591906
    pos 0.762431032250866
    cpu 72
    max_cpu 72
  ]
  node [
    id 9
    label "9"
    pos 0.06656741339382288
    pos 0.4426513746830646
    cpu 100
    max_cpu 100
  ]
  node [
    id 10
    label "10"
    pos 0.5783435201327877
    pos 0.08911394554177998
    cpu 100
    max_cpu 100
  ]
  node [
    id 11
    label "11"
    pos 0.9818416387214586
    pos 0.6429277693127701
    cpu 54
    max_cpu 54
  ]
  node [
    id 12
    label "12"
    pos 0.7346336224804897
    pos 0.6832100712183725
    cpu 77
    max_cpu 77
  ]
  node [
    id 13
    label "13"
    pos 0.11653495000271752
    pos 0.8939744858884368
    cpu 84
    max_cpu 84
  ]
  node [
    id 14
    label "14"
    pos 0.3263049077859682
    pos 0.23154943908648917
    cpu 89
    max_cpu 89
  ]
  node [
    id 15
    label "15"
    pos 0.9373506492856875
    pos 0.047606159906127155
    cpu 61
    max_cpu 61
  ]
  node [
    id 16
    label "16"
    pos 0.7539311521957972
    pos 0.3381257381192213
    cpu 91
    max_cpu 91
  ]
  node [
    id 17
    label "17"
    pos 0.6971567020402669
    pos 0.3619066755834749
    cpu 52
    max_cpu 52
  ]
  node [
    id 18
    label "18"
    pos 0.13739837838640356
    pos 0.5432273318182189
    cpu 88
    max_cpu 88
  ]
  node [
    id 19
    label "19"
    pos 0.5775432426565091
    pos 0.28315764505569596
    cpu 73
    max_cpu 73
  ]
  edge [
    source 0
    target 2
    bw 100
    max_bw 100
  ]
  edge [
    source 0
    target 17
    bw 73
    max_bw 73
  ]
  edge [
    source 1
    target 5
    bw 71
    max_bw 71
  ]
  edge [
    source 2
    target 12
    bw 86
    max_bw 86
  ]
  edge [
    source 3
    target 6
    bw 89
    max_bw 89
  ]
  edge [
    source 3
    target 15
    bw 64
    max_bw 64
  ]
  edge [
    source 3
    target 16
    bw 63
    max_bw 63
  ]
  edge [
    source 4
    target 17
    bw 98
    max_bw 98
  ]
  edge [
    source 5
    target 8
    bw 90
    max_bw 90
  ]
  edge [
    source 6
    target 7
    bw 94
    max_bw 94
  ]
  edge [
    source 6
    target 11
    bw 59
    max_bw 59
  ]
  edge [
    source 7
    target 10
    bw 60
    max_bw 60
  ]
  edge [
    source 7
    target 19
    bw 99
    max_bw 99
  ]
  edge [
    source 8
    target 18
    bw 61
    max_bw 61
  ]
  edge [
    source 8
    target 19
    bw 91
    max_bw 91
  ]
  edge [
    source 9
    target 13
    bw 100
    max_bw 100
  ]
  edge [
    source 9
    target 18
    bw 92
    max_bw 92
  ]
  edge [
    source 10
    target 15
    bw 52
    max_bw 52
  ]
  edge [
    source 10
    target 19
    bw 67
    max_bw 67
  ]
  edge [
    source 12
    target 16
    bw 75
    max_bw 75
  ]
  edge [
    source 14
    target 18
    bw 75
    max_bw 75
  ]
  edge [
    source 15
    target 16
    bw 90
    max_bw 90
  ]
]
