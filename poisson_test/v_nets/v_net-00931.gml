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
  id 931
  arrival_time 19971.459604761698
  lifetime 530.117703697447
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 20
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 49
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 44
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 13
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 38
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 36
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 49
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 1
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 11
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 45
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
]
