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
  id 1682
  arrival_time 37431.8142675265
  lifetime 47.04523871713064
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 11
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 22
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 33
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 13
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 44
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 6
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 45
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 18
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 2
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 20
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 40
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 5
    rom 16
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 50
    rom 7
  ]
  node [
    id 13
    label "13"
    cpu 4
    gpu 33
    rom 2
  ]
  node [
    id 14
    label "14"
    cpu 40
    gpu 23
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 10
  ]
  edge [
    source 12
    target 13
    bw 39
  ]
  edge [
    source 13
    target 14
    bw 16
  ]
]
