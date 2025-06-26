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
  id 752
  arrival_time 15927.843800480987
  lifetime 693.5544652242227
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 50
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 1
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 23
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 23
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 25
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 2
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
]
