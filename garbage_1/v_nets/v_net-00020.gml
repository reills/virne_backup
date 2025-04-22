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
  id 20
  arrival_time 529.0373579175504
  lifetime 1115.5112868121623
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 4
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 27
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 5
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 33
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 2
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 40
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 30
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 24
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 12
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 17
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 39
    gpu 13
    rom 27
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 9
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 29
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 36
    gpu 20
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
  edge [
    source 12
    target 13
    bw 2
  ]
]
