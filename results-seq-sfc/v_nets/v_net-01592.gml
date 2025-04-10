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
  id 1592
  arrival_time 35824.37517615844
  lifetime 432.7430129639464
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 43
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 16
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 47
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 12
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 20
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 11
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 18
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
