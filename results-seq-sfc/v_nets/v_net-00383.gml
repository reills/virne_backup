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
  id 383
  arrival_time 7611.648966908877
  lifetime 806.4719458208716
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 33
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 29
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 42
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 8
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 28
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 47
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 30
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 3
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 33
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
]
