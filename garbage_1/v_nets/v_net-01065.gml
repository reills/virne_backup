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
  id 1065
  arrival_time 22390.140517242507
  lifetime 1340.6242197893168
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 43
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 25
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 44
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 34
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 45
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 46
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 1
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 2
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
]
