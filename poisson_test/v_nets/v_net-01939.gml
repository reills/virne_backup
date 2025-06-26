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
  id 1939
  arrival_time 42769.25258927199
  lifetime 49.8156590787127
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 49
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 31
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 33
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 3
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 10
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 32
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 29
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
]
