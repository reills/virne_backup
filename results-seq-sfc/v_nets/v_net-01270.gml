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
  id 1270
  arrival_time 26633.264678263455
  lifetime 1247.69175614233
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 2
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 22
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 23
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 26
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
]
