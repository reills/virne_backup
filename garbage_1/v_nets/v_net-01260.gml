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
  id 1260
  arrival_time 26363.267358505305
  lifetime 1717.4602441141797
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 27
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 18
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 40
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 46
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 27
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 46
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 39
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 12
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 12
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 24
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
]
