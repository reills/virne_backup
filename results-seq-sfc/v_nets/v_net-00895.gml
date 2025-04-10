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
  id 895
  arrival_time 19249.16106928732
  lifetime 52.45837325510491
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 30
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 41
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 9
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 47
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 20
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 11
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 39
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
]
