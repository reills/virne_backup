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
  id 1453
  arrival_time 30602.086601062318
  lifetime 1557.9937286191011
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 24
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 45
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 20
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 45
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 45
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 26
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 20
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
