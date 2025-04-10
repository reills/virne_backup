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
  id 777
  arrival_time 16170.16977962343
  lifetime 594.7942930145927
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 0
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 9
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 42
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 47
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 50
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 46
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 13
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 42
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 20
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 44
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 21
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 18
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 16
    rom 6
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 39
    rom 26
  ]
  node [
    id 14
    label "14"
    cpu 50
    gpu 29
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
  edge [
    source 11
    target 12
    bw 11
  ]
  edge [
    source 12
    target 13
    bw 28
  ]
  edge [
    source 13
    target 14
    bw 43
  ]
]
