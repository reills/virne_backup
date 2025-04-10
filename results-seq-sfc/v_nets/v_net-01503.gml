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
  id 1503
  arrival_time 33407.99780019922
  lifetime 677.4852666326656
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 38
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 0
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 13
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 30
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
]
