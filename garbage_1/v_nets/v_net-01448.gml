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
  id 1448
  arrival_time 30502.19678652178
  lifetime 919.1798073911104
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 45
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 10
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 24
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 29
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 7
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 31
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 31
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 12
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
]
