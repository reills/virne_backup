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
  id 860
  arrival_time 18047.58543695757
  lifetime 1104.4954202860133
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 35
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 22
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 49
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 28
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 30
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 17
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 2
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 23
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 15
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 5
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
]
