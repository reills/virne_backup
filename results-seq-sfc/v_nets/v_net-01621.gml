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
  id 1621
  arrival_time 36199.9219779464
  lifetime 2362.3728148062396
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 18
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 50
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 45
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 43
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 45
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 30
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 24
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 2
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 25
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 13
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 49
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
]
