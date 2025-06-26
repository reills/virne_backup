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
  id 1985
  arrival_time 43374.26367781907
  lifetime 1223.7777603390712
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 5
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 17
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 49
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 37
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
]
