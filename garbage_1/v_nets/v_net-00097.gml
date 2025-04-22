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
  id 97
  arrival_time 1940.3059294795105
  lifetime 1251.0194892303912
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 23
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 35
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 3
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 19
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 41
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 19
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
]
