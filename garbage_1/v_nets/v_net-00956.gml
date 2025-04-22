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
  id 956
  arrival_time 20375.036849079916
  lifetime 887.0557721712609
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 14
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 47
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 20
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 31
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 28
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 16
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 46
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 43
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
]
