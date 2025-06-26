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
  id 613
  arrival_time 12772.917603904993
  lifetime 1461.6712208931576
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 44
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 0
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 0
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 50
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 3
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 38
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
]
