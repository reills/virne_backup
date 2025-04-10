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
  id 1024
  arrival_time 21693.026530958894
  lifetime 429.5618797080169
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 35
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 2
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 40
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
]
