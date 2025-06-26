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
  id 1414
  arrival_time 29614.70887075321
  lifetime 508.00867613252797
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 42
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 38
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 34
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 36
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 44
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 23
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 5
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 44
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 41
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 35
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 18
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 1
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 37
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 10
    rom 30
  ]
  node [
    id 14
    label "14"
    cpu 37
    gpu 22
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 42
  ]
  edge [
    source 13
    target 14
    bw 8
  ]
]
