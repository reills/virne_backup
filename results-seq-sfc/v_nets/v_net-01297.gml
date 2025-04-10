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
  id 1297
  arrival_time 27099.306678826877
  lifetime 1700.4223598604897
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 47
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 37
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 17
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 29
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 21
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 43
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
]
