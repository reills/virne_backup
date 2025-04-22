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
  id 1071
  arrival_time 22464.969938558257
  lifetime 1008.3890572231935
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 25
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 24
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 43
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 38
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 44
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 15
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 45
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 33
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
]
