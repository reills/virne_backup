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
  id 727
  arrival_time 15318.301394631433
  lifetime 2924.540580637309
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 12
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 40
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 33
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 16
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 47
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 44
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
]
