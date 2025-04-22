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
  id 576
  arrival_time 10768.24236748055
  lifetime 137.85839157829244
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 23
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 3
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 8
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 46
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 36
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
]
