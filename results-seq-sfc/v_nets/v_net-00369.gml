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
  id 369
  arrival_time 7005.537254906534
  lifetime 115.3068234812255
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 48
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 41
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 16
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 38
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 14
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 48
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 46
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 47
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 0
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 35
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 21
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 24
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 46
    gpu 8
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
]
