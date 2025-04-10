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
  id 141
  arrival_time 2397.655429172429
  lifetime 1481.2277839432359
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 3
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 28
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 4
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 33
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 39
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 38
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 40
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 16
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 42
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 21
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
]
