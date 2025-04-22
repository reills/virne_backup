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
  id 1154
  arrival_time 23986.081614797295
  lifetime 1153.337037749672
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 43
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 38
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 2
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 22
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 31
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 40
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 47
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 2
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 18
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 14
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
]
