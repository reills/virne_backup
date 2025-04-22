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
  id 1582
  arrival_time 35714.54075227427
  lifetime 398.78628104004906
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 49
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 21
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 16
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 45
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 41
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 43
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 33
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 3
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 14
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
]
