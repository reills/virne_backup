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
  id 188
  arrival_time 3405.268373850129
  lifetime 1284.011563667253
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 14
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 1
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 13
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 35
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 24
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 20
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 33
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 42
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 18
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 35
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 19
    rom 33
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 25
    rom 24
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 38
    rom 23
  ]
  node [
    id 13
    label "13"
    cpu 4
    gpu 23
    rom 14
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
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
  edge [
    source 12
    target 13
    bw 3
  ]
]
