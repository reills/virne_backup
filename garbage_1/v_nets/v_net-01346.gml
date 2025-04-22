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
  id 1346
  arrival_time 28440.86000810522
  lifetime 2105.4924958474044
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 12
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 48
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 15
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 7
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 10
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 21
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 6
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 6
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 10
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 45
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 22
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 43
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 20
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 8
    gpu 31
    rom 43
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 42
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 15
  ]
  edge [
    source 12
    target 13
    bw 27
  ]
  edge [
    source 13
    target 14
    bw 34
  ]
]
