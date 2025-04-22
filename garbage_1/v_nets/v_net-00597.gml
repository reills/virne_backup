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
  id 597
  arrival_time 12287.686506940401
  lifetime 815.9739999672263
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 31
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 27
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 12
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 28
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 7
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 39
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 42
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 22
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 40
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 26
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 18
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 40
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 45
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 37
    gpu 13
    rom 11
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 38
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
  edge [
    source 13
    target 14
    bw 32
  ]
]
