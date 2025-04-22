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
  id 1742
  arrival_time 38930.18639490133
  lifetime 684.583710906318
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 42
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 1
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 9
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 28
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 33
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 5
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 8
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 0
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 20
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 13
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 34
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 9
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 21
    rom 44
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 3
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 44
  ]
  edge [
    source 12
    target 13
    bw 11
  ]
]
