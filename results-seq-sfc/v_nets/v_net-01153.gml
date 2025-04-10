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
  id 1153
  arrival_time 23978.06659001777
  lifetime 5653.9505061356
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 35
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 19
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 30
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 37
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 13
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 11
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
]
