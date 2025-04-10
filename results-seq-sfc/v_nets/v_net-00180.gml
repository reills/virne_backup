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
  id 180
  arrival_time 3323.6472405545755
  lifetime 997.0581934870166
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 30
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 22
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 43
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 18
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 33
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 0
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 37
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
]
