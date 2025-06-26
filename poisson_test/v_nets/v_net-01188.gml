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
  id 1188
  arrival_time 24681.884511484113
  lifetime 49.47197376945675
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 8
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 44
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 29
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 35
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 12
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 41
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 34
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 16
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 16
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 48
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 43
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 45
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 33
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 25
    gpu 11
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 10
  ]
]
