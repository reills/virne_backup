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
  id 1425
  arrival_time 29729.816263774643
  lifetime 487.2166136759107
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 11
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 13
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 48
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 6
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
]
