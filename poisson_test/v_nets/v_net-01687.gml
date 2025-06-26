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
  id 1687
  arrival_time 37591.68681321587
  lifetime 283.46021610345286
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 9
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 15
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 45
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 7
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 8
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 2
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
]
