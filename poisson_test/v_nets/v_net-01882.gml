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
  id 1882
  arrival_time 41471.54143367933
  lifetime 673.1248693135375
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 37
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 35
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 39
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 7
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 33
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 12
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 11
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
]
