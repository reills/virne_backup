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
  id 1741
  arrival_time 38926.90317360364
  lifetime 255.81258712196527
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 34
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 47
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 47
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 33
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 46
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 36
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 27
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 5
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 40
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 21
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 33
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 42
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
]
