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
  id 302
  arrival_time 5785.530881010239
  lifetime 3416.7987097107534
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 19
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 7
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 38
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 48
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 44
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 12
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 25
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 30
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 49
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 15
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 47
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
]
