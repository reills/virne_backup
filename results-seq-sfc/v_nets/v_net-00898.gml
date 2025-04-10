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
  id 898
  arrival_time 19270.170100113894
  lifetime 1818.0925184060695
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 12
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 4
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 23
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 49
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 0
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 48
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 42
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 14
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 32
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 28
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 38
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 39
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
]
