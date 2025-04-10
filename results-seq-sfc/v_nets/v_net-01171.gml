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
  id 1171
  arrival_time 24220.047662113622
  lifetime 100.65754386386601
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 5
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 31
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 43
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 23
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 32
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 37
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 43
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 27
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 10
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 48
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 5
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 3
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
]
