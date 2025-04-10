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
  id 1436
  arrival_time 30174.196927415403
  lifetime 1028.3213747830268
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 5
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 17
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 10
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 28
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 23
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 30
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 15
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 16
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 12
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 43
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
