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
  id 1412
  arrival_time 29596.63520084876
  lifetime 1125.0923016339884
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 13
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 8
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 49
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 12
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 32
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 27
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 39
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 16
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
]
