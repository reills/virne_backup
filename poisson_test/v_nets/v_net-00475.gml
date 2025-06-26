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
  id 475
  arrival_time 8857.898182485229
  lifetime 427.78421096617456
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 26
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 1
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 26
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 48
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 18
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 48
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 24
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 11
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 3
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
]
