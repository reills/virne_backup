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
  id 332
  arrival_time 6342.474382614503
  lifetime 626.2245381715244
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 9
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 49
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 33
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 19
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 17
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 33
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 23
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
]
