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
  id 569
  arrival_time 10730.943093011063
  lifetime 1034.471422556799
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 18
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 11
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 1
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
]
