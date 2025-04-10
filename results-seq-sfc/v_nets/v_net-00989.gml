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
  id 989
  arrival_time 21145.123542487247
  lifetime 19.485832623298343
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 1
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 2
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 37
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 9
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 38
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 20
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 42
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
