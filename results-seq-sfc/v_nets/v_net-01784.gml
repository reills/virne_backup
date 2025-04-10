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
  id 1784
  arrival_time 39759.921225441765
  lifetime 455.15394997500334
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 33
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 34
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 26
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 2
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 41
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 30
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 10
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 20
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 38
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 32
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 25
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 1
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]
