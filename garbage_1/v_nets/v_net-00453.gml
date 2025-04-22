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
  id 453
  arrival_time 8637.24049979274
  lifetime 1031.9266943057323
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 15
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 23
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 11
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 1
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 31
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 42
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 36
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 21
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 26
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 24
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 21
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 8
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
