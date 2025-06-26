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
  id 769
  arrival_time 16099.359090730059
  lifetime 742.0828707873588
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 38
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 6
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 1
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 38
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 26
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 2
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 32
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 19
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 23
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
]
