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
  id 1763
  arrival_time 39409.28132343819
  lifetime 118.22158032637692
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 33
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 1
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 31
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 27
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 45
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 38
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 12
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 0
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 4
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 23
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
]
