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
  id 925
  arrival_time 19890.845187606712
  lifetime 1085.5628515762028
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 0
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 25
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 10
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 36
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 35
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 3
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
]
