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
  id 821
  arrival_time 17051.028523713263
  lifetime 23.13010190021287
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 18
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 15
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 28
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 44
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 31
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 12
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
]
