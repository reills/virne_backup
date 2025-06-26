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
  id 787
  arrival_time 16227.813059581473
  lifetime 37.73486453459568
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 35
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 17
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 37
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 7
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 43
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 31
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 20
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
]
