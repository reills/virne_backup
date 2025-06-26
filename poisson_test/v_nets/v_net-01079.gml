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
  id 1079
  arrival_time 22573.640437687613
  lifetime 31.256993839139454
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 0
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 2
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 49
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 36
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 13
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 19
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 39
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 23
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 22
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 38
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 17
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 7
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 37
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
]
