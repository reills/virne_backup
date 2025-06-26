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
  id 1355
  arrival_time 28647.156422043063
  lifetime 1544.268154029017
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 8
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 41
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 24
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 17
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 14
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 37
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 5
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 20
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 49
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 12
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 7
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 9
    rom 36
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 49
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 12
    rom 47
  ]
  node [
    id 14
    label "14"
    cpu 2
    gpu 49
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 8
  ]
  edge [
    source 8
    target 9
    bw 26
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
  edge [
    source 12
    target 13
    bw 46
  ]
  edge [
    source 13
    target 14
    bw 25
  ]
]
