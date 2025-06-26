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
  id 748
  arrival_time 15884.029097117382
  lifetime 319.13751685129944
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 35
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 15
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 0
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 29
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
]
