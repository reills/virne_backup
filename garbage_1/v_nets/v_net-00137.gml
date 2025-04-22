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
  id 137
  arrival_time 2373.450599960669
  lifetime 326.11787923158187
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 27
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 36
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 18
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 2
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 49
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 1
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 43
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 5
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 22
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 44
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 47
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
]
