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
  id 107
  arrival_time 2017.163047880071
  lifetime 133.98781473055922
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 11
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 40
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 35
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 0
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 4
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 2
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 47
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
]
