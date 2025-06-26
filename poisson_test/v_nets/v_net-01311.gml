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
  id 1311
  arrival_time 27479.64939062973
  lifetime 553.2909829106401
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 4
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 32
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 22
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 1
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 21
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 19
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 19
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 3
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 50
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 15
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 5
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 32
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 7
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
]
