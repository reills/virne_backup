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
  id 1281
  arrival_time 26761.3850779297
  lifetime 2563.1934765063156
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 14
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 14
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 39
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 42
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 30
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 26
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 3
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 42
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 36
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 37
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 13
    rom 25
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 25
    rom 7
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 49
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 41
    gpu 30
    rom 42
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 33
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
  edge [
    source 13
    target 14
    bw 31
  ]
]
