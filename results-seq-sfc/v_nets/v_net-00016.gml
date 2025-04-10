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
  id 16
  arrival_time 467.137131946561
  lifetime 1104.6572203193564
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 41
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 47
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 2
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 1
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 16
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 7
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 14
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 7
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 45
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 50
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 31
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 29
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
]
