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
  id 334
  arrival_time 6343.449271416865
  lifetime 483.16854236395204
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 10
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 12
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 2
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 40
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 37
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 30
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 0
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
]
