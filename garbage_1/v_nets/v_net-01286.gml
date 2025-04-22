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
  id 1286
  arrival_time 26817.827942615044
  lifetime 4733.709847948034
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 44
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 32
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 41
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 20
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 6
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 46
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 12
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
]
