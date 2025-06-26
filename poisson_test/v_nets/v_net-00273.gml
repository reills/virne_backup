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
  id 273
  arrival_time 5292.504545379996
  lifetime 1252.756219307
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 2
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 44
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 4
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 18
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 41
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 38
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 22
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 41
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 29
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 39
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 46
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 27
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 4
    gpu 34
    rom 44
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 44
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 42
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
]
