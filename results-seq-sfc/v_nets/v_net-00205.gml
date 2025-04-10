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
  id 205
  arrival_time 3618.3519905077014
  lifetime 1040.3061874407808
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 27
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 31
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 10
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 3
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 48
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
