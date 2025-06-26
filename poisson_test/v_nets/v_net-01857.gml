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
  id 1857
  arrival_time 40916.6368165402
  lifetime 26.988901806349006
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 21
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 33
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 23
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 45
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 41
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 37
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 31
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
]
