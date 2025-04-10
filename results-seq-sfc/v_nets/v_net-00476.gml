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
  id 476
  arrival_time 8858.221793758197
  lifetime 163.12267898924568
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 50
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 50
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 33
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 43
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 5
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 9
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 26
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 14
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 18
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 44
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 30
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 43
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 4
    gpu 25
    rom 43
  ]
  node [
    id 13
    label "13"
    cpu 0
    gpu 32
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 14
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
]
