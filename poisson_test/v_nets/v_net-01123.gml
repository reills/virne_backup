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
  id 1123
  arrival_time 23338.137850519735
  lifetime 467.12098735792136
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 13
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 23
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 6
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 12
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 6
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
]
