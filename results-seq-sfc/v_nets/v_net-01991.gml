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
  id 1991
  arrival_time 43436.6730697503
  lifetime 1543.8967813130557
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 34
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 13
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 28
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 31
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 40
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 42
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 2
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
