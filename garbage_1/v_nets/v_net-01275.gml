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
  id 1275
  arrival_time 26722.395030638796
  lifetime 504.92716790048996
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 15
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 21
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 49
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 1
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 32
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 19
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 35
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
]
