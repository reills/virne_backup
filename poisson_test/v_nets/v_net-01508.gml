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
  id 1508
  arrival_time 33586.58128384851
  lifetime 751.3457300994005
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 12
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 6
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 23
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
]
