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
  id 1155
  arrival_time 24053.560134218347
  lifetime 218.85901817947249
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 46
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 19
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 48
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 22
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 7
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
]
