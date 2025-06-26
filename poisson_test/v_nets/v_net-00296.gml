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
  id 296
  arrival_time 5707.892832414428
  lifetime 605.8176167987342
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 10
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 35
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 39
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 21
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 3
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 46
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 45
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
]
