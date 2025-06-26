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
  id 1376
  arrival_time 29195.45699995717
  lifetime 75.46428727946528
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 7
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 35
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 8
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 14
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 31
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 38
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 9
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 8
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 14
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 41
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 24
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 19
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 14
    rom 1
  ]
  node [
    id 13
    label "13"
    cpu 40
    gpu 50
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
]
