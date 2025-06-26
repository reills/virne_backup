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
  id 1883
  arrival_time 41475.46461187567
  lifetime 363.16675661209183
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 37
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 30
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 38
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 31
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 38
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 37
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 45
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 13
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
]
