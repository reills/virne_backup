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
  id 198
  arrival_time 3556.2908689762744
  lifetime 607.5921825455304
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 18
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 39
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 19
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 6
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 38
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 2
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 39
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 0
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 40
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
]
