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
  id 478
  arrival_time 8876.906083945785
  lifetime 2058.765659954029
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 37
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 31
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 25
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 49
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 21
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 1
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 28
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 12
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 40
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 30
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 29
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 31
    rom 43
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 7
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 46
    gpu 48
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
]
