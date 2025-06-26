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
  id 840
  arrival_time 17497.853990902408
  lifetime 685.7523259288243
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 15
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 10
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 31
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 25
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 7
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
]
