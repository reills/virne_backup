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
  id 1747
  arrival_time 38975.49689962692
  lifetime 1121.8409097659487
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 8
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 14
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 50
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 10
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 18
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 10
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 24
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 0
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 12
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 42
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 48
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 13
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 7
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]
