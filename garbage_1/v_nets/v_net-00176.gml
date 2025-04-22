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
  id 176
  arrival_time 3294.505885948512
  lifetime 1016.8421030211199
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 34
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 14
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 50
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 7
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 4
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 44
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 49
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 6
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
]
