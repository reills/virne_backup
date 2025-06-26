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
  id 1772
  arrival_time 39455.283373722785
  lifetime 1.0124400666079685
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 45
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 23
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 17
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 43
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 19
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 24
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 39
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 45
    rom 43
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 10
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
]
