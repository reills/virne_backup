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
  id 557
  arrival_time 10510.14222268426
  lifetime 2054.351272724589
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 24
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 35
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 13
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 44
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 39
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 45
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 36
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 19
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 42
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 43
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 31
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 11
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 12
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
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
