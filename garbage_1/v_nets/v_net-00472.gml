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
  id 472
  arrival_time 8822.653155265403
  lifetime 219.79926363817546
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 1
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 15
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 14
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 41
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 25
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 26
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 44
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 29
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
]
