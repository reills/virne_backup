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
  id 1129
  arrival_time 23525.807650435527
  lifetime 20.33483527294113
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 26
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 7
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 36
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 10
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 45
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 19
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
]
