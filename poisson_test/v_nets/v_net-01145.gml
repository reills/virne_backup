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
  id 1145
  arrival_time 23933.355242448088
  lifetime 591.3037917558318
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 35
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 35
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 31
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 15
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 20
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 25
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 45
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 32
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 20
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 11
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 28
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
]
