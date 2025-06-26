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
  id 1229
  arrival_time 25432.4864577048
  lifetime 873.9059118638485
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 19
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 14
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 23
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 37
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 18
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 3
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 2
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 40
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 48
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 1
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 38
    rom 48
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 35
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 24
    gpu 21
    rom 9
  ]
  node [
    id 13
    label "13"
    cpu 18
    gpu 14
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 14
  ]
  edge [
    source 11
    target 12
    bw 25
  ]
  edge [
    source 12
    target 13
    bw 17
  ]
]
