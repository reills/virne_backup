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
  id 699
  arrival_time 14755.020095817841
  lifetime 1141.2952482898415
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 32
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 38
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 24
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 33
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
]
