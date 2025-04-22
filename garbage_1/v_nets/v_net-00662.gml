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
  id 662
  arrival_time 14137.189363765197
  lifetime 813.0229698387227
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 49
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 43
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 49
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 6
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 16
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 18
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 27
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
]
