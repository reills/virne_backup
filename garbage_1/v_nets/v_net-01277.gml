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
  id 1277
  arrival_time 26747.492515235434
  lifetime 2287.3747244417323
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 18
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 32
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 49
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 26
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 38
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 5
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 35
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
]
