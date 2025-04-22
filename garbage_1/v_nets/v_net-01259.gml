graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1259
  arrival_time 26284.23841874605
  lifetime 373.6467347369966
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 30
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 40
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 5
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 10
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 41
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 35
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 44
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 31
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 14
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 6
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 46
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 32
    rom 50
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 38
    rom 30
  ]
  node [
    id 13
    label "13"
    cpu 40
    gpu 30
    rom 4
  ]
  node [
    id 14
    label "14"
    cpu 35
    gpu 48
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
  edge [
    source 12
    target 13
    bw 23
  ]
  edge [
    source 13
    target 14
    bw 46
  ]
]
