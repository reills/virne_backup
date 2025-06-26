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
  id 1879
  arrival_time 41444.28364902691
  lifetime 149.8017932591798
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 8
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 14
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 14
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 19
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 47
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 39
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
]
