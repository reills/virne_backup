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
  id 984
  arrival_time 20968.085362507285
  lifetime 2794.209319461951
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 13
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 13
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 27
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 22
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 4
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 13
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
