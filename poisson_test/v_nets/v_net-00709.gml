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
  id 709
  arrival_time 14846.971522584774
  lifetime 144.72499009292116
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 38
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 18
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 44
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 5
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 19
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 1
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 19
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 47
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 32
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 33
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 40
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 19
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 19
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 7
    gpu 13
    rom 4
  ]
  node [
    id 14
    label "14"
    cpu 25
    gpu 21
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 24
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
  edge [
    source 12
    target 13
    bw 23
  ]
  edge [
    source 13
    target 14
    bw 1
  ]
]
