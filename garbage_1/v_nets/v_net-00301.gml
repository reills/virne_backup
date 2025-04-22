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
  id 301
  arrival_time 5773.585652574308
  lifetime 937.823890426304
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 18
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 43
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 26
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 43
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 14
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 23
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 27
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 21
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 11
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 38
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
]
