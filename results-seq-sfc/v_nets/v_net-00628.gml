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
  id 628
  arrival_time 12905.465484926097
  lifetime 390.5471305280499
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 3
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 2
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 9
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 45
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
]
