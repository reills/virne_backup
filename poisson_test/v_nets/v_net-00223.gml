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
  id 223
  arrival_time 4095.5268481003586
  lifetime 137.23272042204843
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 7
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 37
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 38
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 4
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 15
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 35
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 22
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 6
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 5
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 46
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 1
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 22
    gpu 5
    rom 19
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 14
    rom 43
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 22
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
  edge [
    source 12
    target 13
    bw 32
  ]
]
