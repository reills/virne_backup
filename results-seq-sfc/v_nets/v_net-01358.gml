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
  id 1358
  arrival_time 28703.22173802847
  lifetime 242.44016448300033
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 48
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 32
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 6
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 17
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 47
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 39
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 39
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 30
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
]
