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
  id 79
  arrival_time 1626.6213335010218
  lifetime 202.0004974166476
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 9
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 15
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 1
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 36
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 3
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 18
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 26
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
]
