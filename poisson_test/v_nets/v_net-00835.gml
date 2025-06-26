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
  id 835
  arrival_time 17348.929689790202
  lifetime 46.61505768688797
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 8
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 18
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 46
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 31
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 8
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 16
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 18
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 19
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 28
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 8
  ]
]
