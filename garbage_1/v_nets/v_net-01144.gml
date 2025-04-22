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
  id 1144
  arrival_time 23925.0764851248
  lifetime 262.68960094010436
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 30
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 0
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 36
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 32
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 21
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
]
