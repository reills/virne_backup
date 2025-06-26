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
  id 844
  arrival_time 17506.505746423587
  lifetime 463.8153497019405
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 3
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 46
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 11
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 42
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 3
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 12
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 25
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 40
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 1
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 37
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 42
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 35
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 12
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 34
  ]
]
