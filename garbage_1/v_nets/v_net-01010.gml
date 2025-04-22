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
  id 1010
  arrival_time 21557.62724912836
  lifetime 713.9641038906873
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 34
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 28
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 14
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 47
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 34
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 30
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 41
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 28
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 31
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 24
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 31
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 36
    rom 24
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 25
    rom 10
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 24
    rom 33
  ]
  node [
    id 14
    label "14"
    cpu 41
    gpu 7
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 39
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
