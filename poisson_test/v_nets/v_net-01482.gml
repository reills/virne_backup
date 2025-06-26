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
  id 1482
  arrival_time 32200.90940671258
  lifetime 158.5977566748232
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 8
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 49
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 9
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 27
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 35
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 13
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 50
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 34
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
]
