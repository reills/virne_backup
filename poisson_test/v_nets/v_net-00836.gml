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
  id 836
  arrival_time 17352.82139531947
  lifetime 50.12066790671681
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 16
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 0
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 44
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 19
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 44
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 37
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 36
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 3
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 23
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
]
