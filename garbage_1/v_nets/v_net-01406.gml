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
  id 1406
  arrival_time 29449.047917748652
  lifetime 2833.9611902140155
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 47
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 34
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 6
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 25
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 19
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 30
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 32
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 29
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 31
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 25
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 27
    rom 25
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 1
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
]
