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
  id 812
  arrival_time 16814.83207445383
  lifetime 128.20179931000123
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 7
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 30
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 15
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 13
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 43
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 42
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 49
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 46
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 10
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
]
