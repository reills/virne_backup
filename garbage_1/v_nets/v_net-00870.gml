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
  id 870
  arrival_time 18115.716517348625
  lifetime 396.0562782975683
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 28
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 12
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 44
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 8
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 43
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
]
