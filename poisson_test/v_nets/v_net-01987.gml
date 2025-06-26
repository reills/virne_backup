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
  id 1987
  arrival_time 43391.2423353528
  lifetime 1602.669400204428
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 30
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 41
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 50
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 13
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 11
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 45
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 19
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 7
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 44
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 47
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 29
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 27
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 32
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 42
    gpu 29
    rom 9
  ]
  node [
    id 14
    label "14"
    cpu 7
    gpu 9
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 23
  ]
  edge [
    source 12
    target 13
    bw 2
  ]
  edge [
    source 13
    target 14
    bw 8
  ]
]
