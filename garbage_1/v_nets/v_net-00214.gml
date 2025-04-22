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
  id 214
  arrival_time 3839.5754553148568
  lifetime 1331.47116309694
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 20
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 3
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 28
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 37
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 32
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
]
