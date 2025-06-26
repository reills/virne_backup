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
  id 1937
  arrival_time 42667.45044508108
  lifetime 449.1519942193824
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 43
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 2
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 28
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 45
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 9
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 15
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 49
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 0
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 38
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 21
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 36
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 28
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 42
  ]
]
