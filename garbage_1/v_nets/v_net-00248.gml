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
  id 248
  arrival_time 4750.87837677691
  lifetime 230.85547070022022
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 9
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 24
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 3
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 18
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 46
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 17
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 21
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 19
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 5
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 42
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 17
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 9
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
]
