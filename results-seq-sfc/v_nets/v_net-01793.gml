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
  id 1793
  arrival_time 39858.043945307974
  lifetime 5.347024096527301
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 43
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 19
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 35
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 30
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 21
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 35
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 23
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 15
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 44
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 26
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 34
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 45
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 6
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 24
    gpu 34
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 3
    gpu 48
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 47
  ]
  edge [
    source 13
    target 14
    bw 26
  ]
]
