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
  id 1710
  arrival_time 38113.28011561514
  lifetime 1909.2548967925293
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 33
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 3
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 37
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 34
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 20
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 41
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 3
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 45
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 46
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 15
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 34
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 50
    gpu 41
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 18
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
]
