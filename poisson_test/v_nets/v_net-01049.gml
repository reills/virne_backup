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
  id 1049
  arrival_time 22138.836533778172
  lifetime 115.00818400564003
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 47
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 14
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 40
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 26
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 38
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
]
