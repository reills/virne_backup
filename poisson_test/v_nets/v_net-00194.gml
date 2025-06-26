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
  id 194
  arrival_time 3509.4050694777397
  lifetime 296.1722374823744
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 27
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 7
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 3
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 6
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 32
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 16
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 6
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 35
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 12
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 25
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 21
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 38
    rom 32
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 49
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 45
    gpu 6
    rom 20
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 37
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 11
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
  edge [
    source 13
    target 14
    bw 28
  ]
]
