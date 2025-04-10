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
  id 915
  arrival_time 19638.32792546044
  lifetime 281.0194417468184
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 23
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 3
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 9
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
]
