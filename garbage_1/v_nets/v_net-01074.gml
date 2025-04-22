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
  id 1074
  arrival_time 22477.020500097646
  lifetime 279.2254238828608
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 38
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 8
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 25
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 48
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 9
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]
