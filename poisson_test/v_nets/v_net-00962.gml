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
  id 962
  arrival_time 20467.282985888367
  lifetime 326.5593827977078
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 0
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 30
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 27
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 10
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 47
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 20
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 17
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 42
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
]
