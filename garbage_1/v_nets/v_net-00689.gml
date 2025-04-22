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
  id 689
  arrival_time 14574.032094117103
  lifetime 1757.0428410927418
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 26
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 43
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 34
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 5
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 1
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 5
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
]
