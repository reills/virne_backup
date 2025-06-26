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
  id 181
  arrival_time 3324.9927321559
  lifetime 3005.910404673901
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 38
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 24
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 48
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 16
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 15
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 11
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
]
