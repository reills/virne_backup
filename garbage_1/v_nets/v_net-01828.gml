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
  id 1828
  arrival_time 40418.47906198673
  lifetime 828.2442198444259
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 13
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 19
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 49
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 9
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 48
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 19
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 23
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 17
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 35
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
]
