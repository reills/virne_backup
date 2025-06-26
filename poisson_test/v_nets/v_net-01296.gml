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
  id 1296
  arrival_time 27096.204679927177
  lifetime 396.30890319407587
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 10
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 39
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 1
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 6
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 46
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 22
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 4
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 21
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
]
