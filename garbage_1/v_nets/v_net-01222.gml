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
  id 1222
  arrival_time 25376.139030515133
  lifetime 806.4856749213268
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 39
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 48
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 31
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
]
