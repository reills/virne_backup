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
  id 515
  arrival_time 9833.2568330904
  lifetime 433.36710933550984
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 13
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 50
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 19
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
]
