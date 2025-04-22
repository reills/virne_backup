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
  id 528
  arrival_time 10101.571131667197
  lifetime 24.379166531954414
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 37
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 39
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 0
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 15
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 11
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
]
