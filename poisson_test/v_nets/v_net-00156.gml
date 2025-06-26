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
  id 156
  arrival_time 3020.9354940616395
  lifetime 4992.30548023362
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 5
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 39
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 46
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 10
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 3
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 1
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
]
