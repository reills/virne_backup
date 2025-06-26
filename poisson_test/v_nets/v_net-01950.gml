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
  id 1950
  arrival_time 42829.71882842423
  lifetime 464.53974037839066
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 36
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 33
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 43
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 43
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 6
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
]
