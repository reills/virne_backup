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
  id 677
  arrival_time 14373.015286791882
  lifetime 228.1085306898794
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 46
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 18
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 34
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 2
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
]
