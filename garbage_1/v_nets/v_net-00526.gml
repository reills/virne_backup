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
  id 526
  arrival_time 10069.539227886236
  lifetime 411.3589274117509
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 14
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 25
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 10
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 40
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 32
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 38
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
]
