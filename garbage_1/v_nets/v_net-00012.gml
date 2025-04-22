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
  id 12
  arrival_time 230.33443414840673
  lifetime 706.309886399697
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 1
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 12
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 2
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 38
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 11
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 31
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 3
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
]
