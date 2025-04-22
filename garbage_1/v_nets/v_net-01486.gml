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
  id 1486
  arrival_time 32251.307902385663
  lifetime 339.986247666934
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 41
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 12
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 27
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 27
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 15
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 17
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 26
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 4
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 5
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 23
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
]
