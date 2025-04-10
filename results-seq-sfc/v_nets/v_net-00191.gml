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
  id 191
  arrival_time 3504.793664827634
  lifetime 804.3586453669279
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 50
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 3
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 35
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
]
