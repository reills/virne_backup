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
  id 848
  arrival_time 17560.52308606812
  lifetime 285.85109471419844
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 29
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 7
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 14
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 21
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 12
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 2
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 33
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 6
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
]
