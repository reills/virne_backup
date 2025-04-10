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
  id 608
  arrival_time 12727.935134266005
  lifetime 1387.9931235720426
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 3
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 13
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 42
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 30
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 49
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
]
