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
  id 357
  arrival_time 6828.7753395959535
  lifetime 376.2740624682376
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 15
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 6
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 0
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 37
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 11
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 37
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
]
