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
  id 1986
  arrival_time 43384.87357481417
  lifetime 2606.1733231635662
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 19
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 39
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 5
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 27
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 0
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 42
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 16
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 29
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
]
