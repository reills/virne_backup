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
  id 1192
  arrival_time 24709.054385707776
  lifetime 505.8465897715738
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 46
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 47
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 27
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 29
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 0
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 12
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 21
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 14
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
]
