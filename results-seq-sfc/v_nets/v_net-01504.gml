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
  id 1504
  arrival_time 33428.31598578791
  lifetime 120.19706645506352
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 8
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 17
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 45
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 28
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 21
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 5
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 11
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 17
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 35
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 43
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 44
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 17
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
]
