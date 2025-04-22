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
  id 1910
  arrival_time 42043.34311350542
  lifetime 1526.1370456855261
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 15
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 38
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 15
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 30
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 44
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 39
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 38
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 12
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
]
