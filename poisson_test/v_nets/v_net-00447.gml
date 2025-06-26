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
  id 447
  arrival_time 8579.087144679419
  lifetime 3234.1816384093026
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 47
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 28
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 5
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 3
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 22
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 14
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 42
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 33
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 10
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 7
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 31
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 10
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 8
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
]
