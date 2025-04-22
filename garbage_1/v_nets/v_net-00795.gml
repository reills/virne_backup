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
  id 795
  arrival_time 16626.28090874551
  lifetime 1012.9287032543568
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 0
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 10
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 26
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
]
