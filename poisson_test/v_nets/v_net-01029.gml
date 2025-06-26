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
  id 1029
  arrival_time 21856.68016642091
  lifetime 1055.6768859075314
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 34
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 43
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 2
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 42
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 19
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 37
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 47
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 29
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 44
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 2
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 48
    rom 7
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 20
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 32
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 49
    gpu 29
    rom 3
  ]
  node [
    id 14
    label "14"
    cpu 40
    gpu 2
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
  edge [
    source 13
    target 14
    bw 26
  ]
]
