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
  id 1984
  arrival_time 43359.42446630869
  lifetime 118.39293512601972
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 26
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 30
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 49
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 8
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 46
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 25
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 12
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 24
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 25
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 45
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 49
    rom 27
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 19
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]
