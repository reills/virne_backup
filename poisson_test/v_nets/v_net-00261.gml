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
  id 261
  arrival_time 4941.207347192937
  lifetime 1081.6765335432674
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 32
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 34
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 15
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 8
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 14
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 47
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 25
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 50
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 19
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 2
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 14
    rom 42
  ]
  node [
    id 11
    label "11"
    cpu 25
    gpu 48
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 40
    rom 31
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 43
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
]
