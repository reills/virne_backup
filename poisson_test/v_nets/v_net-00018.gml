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
  id 18
  arrival_time 509.1431848918897
  lifetime 360.3352858359549
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 26
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 27
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 46
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 48
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 22
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
]
