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
  id 1469
  arrival_time 31941.01883735771
  lifetime 230.1156797288926
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 13
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 17
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 10
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 45
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 22
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 20
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 19
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 33
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
]
