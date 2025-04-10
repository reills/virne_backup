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
  id 1834
  arrival_time 40515.30437410605
  lifetime 933.1193225813039
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 29
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 49
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 9
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 15
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 30
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 16
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 49
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
]
