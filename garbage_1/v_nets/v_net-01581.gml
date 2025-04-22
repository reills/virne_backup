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
  id 1581
  arrival_time 35710.58573335149
  lifetime 385.29438713209817
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 30
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 40
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 47
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 5
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 15
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 3
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 1
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 5
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
]
