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
  id 390
  arrival_time 7729.058937153229
  lifetime 153.62809195185588
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 8
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 21
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 48
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
]
