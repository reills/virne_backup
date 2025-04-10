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
  id 368
  arrival_time 6994.201801485373
  lifetime 115.1067511820629
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 15
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 8
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 12
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 20
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 25
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 4
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
]
