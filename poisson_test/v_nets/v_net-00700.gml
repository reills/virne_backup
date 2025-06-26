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
  id 700
  arrival_time 14759.51682699619
  lifetime 120.49399174236076
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 0
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 22
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 19
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 25
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 42
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 32
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 4
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 2
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 20
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 21
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 10
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 32
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 3
    gpu 46
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 10
    gpu 10
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
]
