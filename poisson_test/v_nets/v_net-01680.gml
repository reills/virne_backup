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
  id 1680
  arrival_time 37420.914253314535
  lifetime 441.0435657643608
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 24
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 45
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 42
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 22
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 16
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 11
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 27
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 13
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 10
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 26
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 50
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 1
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 39
    rom 6
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 33
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
]
