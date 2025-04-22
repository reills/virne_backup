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
  id 522
  arrival_time 10019.1533610037
  lifetime 192.57943131573003
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 48
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 30
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 40
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 8
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 3
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 8
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 29
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 10
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
]
