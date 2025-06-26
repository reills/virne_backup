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
  id 1283
  arrival_time 26765.1147259209
  lifetime 498.91648112319996
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 35
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 23
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 21
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 16
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 35
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 39
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 45
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
]
