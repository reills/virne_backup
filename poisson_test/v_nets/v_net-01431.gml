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
  id 1431
  arrival_time 30017.061073086137
  lifetime 2046.7976904054722
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 32
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 25
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 13
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 14
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 20
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 36
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 42
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 5
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 16
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 28
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
]
