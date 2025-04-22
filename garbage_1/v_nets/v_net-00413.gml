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
  id 413
  arrival_time 8114.324454062084
  lifetime 956.2122581385897
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 20
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 41
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 34
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 18
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 36
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 1
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 49
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 22
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 31
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 46
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 8
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 1
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 21
    rom 46
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 19
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 44
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
]
