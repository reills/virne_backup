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
  id 315
  arrival_time 5934.086028654289
  lifetime 523.0223222639498
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 7
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 48
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 24
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 47
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 2
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 42
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
]
