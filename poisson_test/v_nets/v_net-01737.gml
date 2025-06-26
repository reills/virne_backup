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
  id 1737
  arrival_time 38794.694394883154
  lifetime 959.4938777436076
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 1
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 19
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 0
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 4
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 15
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 14
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 46
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 43
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 18
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 34
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 45
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 32
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 40
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
]
