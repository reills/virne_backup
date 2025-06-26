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
  id 7
  arrival_time 131.92558734466527
  lifetime 1469.5955284273282
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 44
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 29
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 37
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
]
