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
  id 1827
  arrival_time 40401.075398775785
  lifetime 755.991975095972
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 49
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 24
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 26
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 49
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 14
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 7
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
