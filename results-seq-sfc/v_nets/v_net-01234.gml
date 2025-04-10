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
  id 1234
  arrival_time 25452.10706912291
  lifetime 40.56224157065485
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 27
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 49
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 31
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
]
