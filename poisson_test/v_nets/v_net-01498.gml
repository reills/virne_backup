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
  id 1498
  arrival_time 33339.55391051325
  lifetime 2847.0315778587747
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 34
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 22
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 9
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 21
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 48
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 0
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
]
