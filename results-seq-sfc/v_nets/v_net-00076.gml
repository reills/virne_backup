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
  id 76
  arrival_time 1566.1798319901711
  lifetime 356.66768218103323
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 36
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 1
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 13
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 16
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 2
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 35
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
]
