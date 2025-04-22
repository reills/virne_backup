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
  id 8
  arrival_time 149.78947864735238
  lifetime 400.12601159028367
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 27
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 18
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 12
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 50
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 15
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 45
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 39
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 48
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 28
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 34
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 33
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 49
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 37
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 0
    gpu 16
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
  edge [
    source 12
    target 13
    bw 6
  ]
]
