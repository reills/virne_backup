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
  id 1360
  arrival_time 28722.35679783914
  lifetime 1553.8063056625315
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 6
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 45
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 23
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 34
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 21
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 50
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 1
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
]
