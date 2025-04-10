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
  id 1732
  arrival_time 38750.19982667564
  lifetime 620.8734931264977
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 7
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 43
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 27
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 12
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]
