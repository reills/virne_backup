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
  id 1112
  arrival_time 23193.524496113798
  lifetime 1607.5177956982452
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 48
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 48
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 14
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 16
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 38
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 26
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 17
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 8
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
]
