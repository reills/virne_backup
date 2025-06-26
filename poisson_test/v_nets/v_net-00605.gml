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
  id 605
  arrival_time 12475.757928236631
  lifetime 1027.6389860989837
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 5
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 16
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 3
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 39
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 4
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 36
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 22
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 8
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
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
]
