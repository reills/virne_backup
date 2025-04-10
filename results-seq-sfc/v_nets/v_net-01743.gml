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
  id 1743
  arrival_time 38933.52709384672
  lifetime 1012.867687572166
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 23
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 45
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 35
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 11
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 2
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 33
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 22
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
