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
  id 178
  arrival_time 3312.308214865542
  lifetime 1380.626571234763
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 25
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 33
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 32
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 30
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 33
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 22
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 50
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 38
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 27
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 21
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 19
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 48
    rom 17
  ]
  node [
    id 12
    label "12"
    cpu 24
    gpu 30
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
]
