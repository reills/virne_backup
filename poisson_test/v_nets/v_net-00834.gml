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
  id 834
  arrival_time 17348.471297666038
  lifetime 514.3534509807639
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 35
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 45
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 40
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 13
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 41
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 37
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 17
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 31
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 35
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 13
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 30
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 11
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 13
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 10
    gpu 49
    rom 14
  ]
  node [
    id 14
    label "14"
    cpu 39
    gpu 38
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
  edge [
    source 12
    target 13
    bw 47
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
