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
  id 1519
  arrival_time 33737.10948204137
  lifetime 1202.4761928187006
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 27
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 41
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 27
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 27
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 27
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 50
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 34
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 15
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
]
