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
  id 1727
  arrival_time 38541.76337309706
  lifetime 1644.828301509554
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 49
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 33
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 11
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 27
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 43
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 15
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 20
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
]
