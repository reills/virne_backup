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
  id 1320
  arrival_time 27626.326652467247
  lifetime 74.26153625656876
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 43
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 42
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 45
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 2
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 43
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 0
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 48
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 41
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 7
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 41
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
]
