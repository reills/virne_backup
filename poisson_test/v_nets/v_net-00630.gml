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
  id 630
  arrival_time 12936.048991202044
  lifetime 4176.377064832213
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 18
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 1
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 4
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 48
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 13
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 0
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 39
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
]
