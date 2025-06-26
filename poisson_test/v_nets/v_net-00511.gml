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
  id 511
  arrival_time 9761.882499692934
  lifetime 207.4590903204984
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 27
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 47
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 40
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 36
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 4
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 47
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 10
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 45
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 35
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
]
