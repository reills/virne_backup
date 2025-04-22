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
  id 736
  arrival_time 15440.397021139388
  lifetime 601.8035635909812
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 32
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 27
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 12
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 25
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 38
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 4
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 36
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 9
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 40
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 43
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 21
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 50
    gpu 30
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
]
