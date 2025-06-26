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
  id 762
  arrival_time 16031.14377762689
  lifetime 444.11707070865674
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 3
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 23
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 49
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 16
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 40
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 27
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 15
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 41
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 35
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 4
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 26
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 47
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 16
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 44
    gpu 28
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 43
    gpu 28
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
  edge [
    source 13
    target 14
    bw 17
  ]
]
