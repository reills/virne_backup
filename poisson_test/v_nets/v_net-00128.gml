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
  id 128
  arrival_time 2233.815566366012
  lifetime 298.8072185360824
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 22
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 16
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 17
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 33
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 5
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 13
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
]
