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
  id 366
  arrival_time 6965.104409285477
  lifetime 56.284431455997805
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 12
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 9
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 37
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
]
