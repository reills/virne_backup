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
  id 28
  arrival_time 578.4994428840547
  lifetime 996.131733669108
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 16
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 47
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 4
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 9
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 46
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 17
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 25
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 10
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 36
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 11
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 38
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 24
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 0
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
]
