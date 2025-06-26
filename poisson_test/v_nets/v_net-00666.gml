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
  id 666
  arrival_time 14181.69787150452
  lifetime 928.5901347776442
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 17
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 4
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 47
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 3
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 35
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 0
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 12
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 30
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 11
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 43
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 6
    rom 27
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 28
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 38
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 41
    gpu 22
    rom 43
  ]
  node [
    id 14
    label "14"
    cpu 32
    gpu 39
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 39
  ]
  edge [
    source 13
    target 14
    bw 35
  ]
]
