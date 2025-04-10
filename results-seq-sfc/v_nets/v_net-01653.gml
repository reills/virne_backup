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
  id 1653
  arrival_time 36873.2813087401
  lifetime 1305.6969262603634
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 42
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 10
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 7
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 21
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 4
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 49
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 28
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
]
