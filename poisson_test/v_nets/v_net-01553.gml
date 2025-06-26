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
  id 1553
  arrival_time 34211.730566132894
  lifetime 505.2426581420149
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 2
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 38
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 27
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 32
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 20
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 14
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 41
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
]
