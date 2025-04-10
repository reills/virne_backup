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
  id 361
  arrival_time 6865.903372168035
  lifetime 1034.5888394023002
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 16
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 39
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 17
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 11
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 25
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 30
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 23
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 39
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 35
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 26
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 49
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 31
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 9
    rom 47
  ]
  node [
    id 13
    label "13"
    cpu 11
    gpu 49
    rom 3
  ]
  node [
    id 14
    label "14"
    cpu 21
    gpu 4
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 14
  ]
  edge [
    source 12
    target 13
    bw 34
  ]
  edge [
    source 13
    target 14
    bw 10
  ]
]
