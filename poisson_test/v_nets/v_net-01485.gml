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
  id 1485
  arrival_time 32243.465205748995
  lifetime 1041.6266097897492
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 2
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 26
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 40
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 0
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 42
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 32
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 7
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 26
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 23
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 43
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 39
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 17
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 46
    gpu 26
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
  edge [
    source 11
    target 12
    bw 1
  ]
]
