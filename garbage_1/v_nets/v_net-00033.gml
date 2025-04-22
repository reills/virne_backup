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
  id 33
  arrival_time 594.9353688387134
  lifetime 642.7749231162738
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 43
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 15
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 12
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 50
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 12
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 20
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 1
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 24
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 15
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 35
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 25
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 15
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 43
    gpu 48
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]
