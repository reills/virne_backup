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
  id 1842
  arrival_time 40700.239369027695
  lifetime 908.9611985262247
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 40
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 21
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 6
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 47
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 49
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 6
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 17
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 22
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 17
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 16
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 26
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
]
