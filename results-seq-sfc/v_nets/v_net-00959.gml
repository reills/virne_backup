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
  id 959
  arrival_time 20382.56379929497
  lifetime 641.8231975979564
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 36
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 21
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 36
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
]
