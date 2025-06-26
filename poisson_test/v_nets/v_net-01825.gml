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
  id 1825
  arrival_time 40387.94719988081
  lifetime 79.47013922557137
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 18
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 25
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 29
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 24
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 50
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 19
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 42
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 25
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 35
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 33
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 26
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 10
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 46
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
]
