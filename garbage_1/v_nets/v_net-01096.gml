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
  id 1096
  arrival_time 22853.075863759277
  lifetime 4031.65400633687
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 6
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 12
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 24
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 7
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 14
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
]
