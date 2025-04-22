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
  id 720
  arrival_time 15204.12411352641
  lifetime 970.1808429281158
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 11
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 34
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 9
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 40
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 50
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
]
