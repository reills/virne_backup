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
  id 1249
  arrival_time 25900.59224118799
  lifetime 785.5461896820461
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 33
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 24
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 21
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 3
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 7
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 9
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 9
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 2
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 33
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 39
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
]
