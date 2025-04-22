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
  id 813
  arrival_time 16821.261699026363
  lifetime 597.948816750701
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 5
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 22
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 27
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 43
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 1
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 2
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 13
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
]
