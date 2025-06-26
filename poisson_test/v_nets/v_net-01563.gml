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
  id 1563
  arrival_time 34994.977141542586
  lifetime 1659.6705236897558
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 19
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 36
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 11
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 10
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 50
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 9
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
]
