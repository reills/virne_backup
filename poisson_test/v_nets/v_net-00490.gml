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
  id 490
  arrival_time 8968.996454518909
  lifetime 1274.7307767489547
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 15
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 8
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 29
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 4
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 32
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 18
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 45
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 31
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
]
