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
  id 1087
  arrival_time 22642.049847916736
  lifetime 101.01434195328586
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 9
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 29
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 47
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 14
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 8
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 0
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 30
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 34
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 49
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 40
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 45
    rom 25
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 2
    rom 25
  ]
  node [
    id 12
    label "12"
    cpu 43
    gpu 29
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
]
