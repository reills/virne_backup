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
  id 449
  arrival_time 8599.08159743293
  lifetime 1612.7194901096107
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 14
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 7
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 24
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 20
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 28
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 12
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 7
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 22
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 8
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 30
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 37
    rom 33
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 48
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 33
    rom 7
  ]
  node [
    id 13
    label "13"
    cpu 26
    gpu 30
    rom 50
  ]
  node [
    id 14
    label "14"
    cpu 31
    gpu 45
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
  edge [
    source 12
    target 13
    bw 10
  ]
  edge [
    source 13
    target 14
    bw 40
  ]
]
