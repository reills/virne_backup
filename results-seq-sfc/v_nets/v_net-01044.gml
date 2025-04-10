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
  id 1044
  arrival_time 22091.752945923
  lifetime 1042.3620536609171
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 13
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 12
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 29
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 24
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 34
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 37
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 44
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 24
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 45
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 32
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 6
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
]
