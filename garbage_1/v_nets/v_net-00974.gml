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
  id 974
  arrival_time 20839.255638372735
  lifetime 376.7898577634048
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 39
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 48
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 50
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 45
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 8
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 11
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 43
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 48
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 34
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 16
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 32
    rom 9
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 3
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 26
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 21
    gpu 17
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
]
