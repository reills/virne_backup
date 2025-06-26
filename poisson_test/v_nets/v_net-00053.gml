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
  id 53
  arrival_time 1073.8568001500753
  lifetime 225.54097083588036
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 43
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 14
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 43
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 40
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 12
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 48
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
]
