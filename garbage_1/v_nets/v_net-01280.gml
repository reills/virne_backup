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
  id 1280
  arrival_time 26760.900533630815
  lifetime 1432.7602337196442
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 1
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 12
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 2
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 21
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 5
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 41
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 45
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 18
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 13
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 49
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 8
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 3
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 4
    rom 3
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 47
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
]
