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
  id 756
  arrival_time 15981.385952090905
  lifetime 1560.6512334843915
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 3
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 38
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 31
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 2
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 7
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 46
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
]
