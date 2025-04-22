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
  id 951
  arrival_time 20302.324376440294
  lifetime 112.90759839777357
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 0
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 48
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 28
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 29
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 40
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 28
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 6
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 21
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
]
