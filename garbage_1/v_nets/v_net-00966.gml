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
  id 966
  arrival_time 20495.671754637737
  lifetime 1419.7322240557903
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 35
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 20
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 36
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 30
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 0
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
]
