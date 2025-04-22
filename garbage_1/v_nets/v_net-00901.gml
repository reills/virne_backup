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
  id 901
  arrival_time 19314.951454512997
  lifetime 548.9275591864945
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 5
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 19
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 31
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 29
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 9
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
]
