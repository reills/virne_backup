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
  id 463
  arrival_time 8757.948727290492
  lifetime 53.966983279485326
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 3
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 27
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 28
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 40
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
]
