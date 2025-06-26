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
  id 282
  arrival_time 5395.683799958064
  lifetime 193.6415768758651
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 9
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 4
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 4
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 36
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 38
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 42
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 25
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
]
