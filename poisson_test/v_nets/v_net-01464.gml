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
  id 1464
  arrival_time 30680.817479340138
  lifetime 1632.9361546732991
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 40
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 22
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 30
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 0
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 38
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 26
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 13
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 43
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 3
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 15
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 47
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
]
