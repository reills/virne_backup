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
  id 1127
  arrival_time 23499.39527939918
  lifetime 274.4360071087033
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 2
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 27
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 16
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 8
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 2
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 44
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
]
