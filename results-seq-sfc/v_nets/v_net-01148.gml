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
  id 1148
  arrival_time 23948.021535181597
  lifetime 90.55475175165574
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 34
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 15
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 38
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 3
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 40
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 24
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 19
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 12
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 42
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 6
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 19
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 17
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 16
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
]
