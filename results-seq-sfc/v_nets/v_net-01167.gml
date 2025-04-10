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
  id 1167
  arrival_time 24206.66136378131
  lifetime 349.76811306138774
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 15
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 49
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 2
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 13
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 23
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 21
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 0
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 18
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 13
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 3
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 30
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 39
    gpu 43
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 16
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 43
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 27
    gpu 26
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
  edge [
    source 12
    target 13
    bw 7
  ]
  edge [
    source 13
    target 14
    bw 49
  ]
]
