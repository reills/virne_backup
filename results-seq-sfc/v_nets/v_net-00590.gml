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
  id 590
  arrival_time 12162.706622265927
  lifetime 1615.3205123035193
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 21
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 26
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 31
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 5
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
]
