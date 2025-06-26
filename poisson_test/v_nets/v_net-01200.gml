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
  id 1200
  arrival_time 24732.53599404147
  lifetime 805.7364886859705
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 2
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 24
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 21
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 8
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 26
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 30
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 37
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 26
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 30
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 17
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 40
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 46
    gpu 39
    rom 41
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 42
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]
