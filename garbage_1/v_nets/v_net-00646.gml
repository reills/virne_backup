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
  id 646
  arrival_time 13672.068828957601
  lifetime 422.84428721358466
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 1
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 6
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 6
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
]
