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
  id 1901
  arrival_time 41939.109468145565
  lifetime 1172.8705921210192
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 11
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 37
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 48
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 6
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 16
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 23
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 50
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 34
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 45
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
]
