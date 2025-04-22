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
  id 99
  arrival_time 1957.7889064029798
  lifetime 2860.7205945214578
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 31
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 50
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 15
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 22
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 35
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 34
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
]
