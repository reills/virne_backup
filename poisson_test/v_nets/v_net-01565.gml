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
  id 1565
  arrival_time 35005.5045907122
  lifetime 454.34037815599305
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 12
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 8
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 27
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 18
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 33
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 2
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 23
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 44
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 49
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 0
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 30
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 15
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 30
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
]
