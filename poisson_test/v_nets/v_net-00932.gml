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
  id 932
  arrival_time 19975.085070380337
  lifetime 345.97520928032407
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 48
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 26
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 20
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 9
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 41
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 29
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 12
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
]
