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
  id 917
  arrival_time 19642.60526729658
  lifetime 686.8625592876928
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 20
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 10
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 43
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 36
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
]
