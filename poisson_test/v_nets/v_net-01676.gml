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
  id 1676
  arrival_time 37319.323903892306
  lifetime 17.161986014036614
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 34
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 2
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 37
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 38
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 23
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 13
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 1
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 44
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 25
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 27
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 19
    rom 9
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 9
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 42
    rom 8
  ]
  node [
    id 13
    label "13"
    cpu 37
    gpu 39
    rom 43
  ]
  node [
    id 14
    label "14"
    cpu 29
    gpu 46
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
  edge [
    source 12
    target 13
    bw 23
  ]
  edge [
    source 13
    target 14
    bw 18
  ]
]
