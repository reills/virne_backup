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
  id 543
  arrival_time 10280.899257964606
  lifetime 589.8316685798862
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 36
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 18
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 41
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 41
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 21
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 46
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 28
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 19
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 50
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 18
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 19
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
]
