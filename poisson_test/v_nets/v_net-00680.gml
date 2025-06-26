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
  id 680
  arrival_time 14387.10889886071
  lifetime 376.3233639785354
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 13
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 5
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 9
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
]
