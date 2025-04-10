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
  id 364
  arrival_time 6955.2811383444305
  lifetime 340.8339972652232
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 13
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 5
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 2
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 9
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 30
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 40
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 37
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 15
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 5
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 18
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
]
