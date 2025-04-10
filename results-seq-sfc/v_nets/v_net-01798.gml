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
  id 1798
  arrival_time 39883.920591880546
  lifetime 2845.1625860230606
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 32
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 3
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 42
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 4
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 34
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 30
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 35
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 4
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 5
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 4
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 14
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 16
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 24
    gpu 25
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
]
