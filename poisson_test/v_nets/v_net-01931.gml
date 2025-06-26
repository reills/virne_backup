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
  id 1931
  arrival_time 42618.097940112806
  lifetime 273.8433900098746
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 4
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 25
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 13
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 16
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 48
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
]
