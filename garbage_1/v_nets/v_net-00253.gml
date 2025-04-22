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
  id 253
  arrival_time 4849.304197111938
  lifetime 789.6339744649363
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 25
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 31
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 7
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 5
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 10
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 47
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 47
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 49
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 17
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 26
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 26
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 3
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 5
    rom 9
  ]
  node [
    id 13
    label "13"
    cpu 33
    gpu 5
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 31
  ]
]
