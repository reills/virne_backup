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
  id 388
  arrival_time 7668.590901321656
  lifetime 29.632213756988044
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 30
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 1
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 2
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 8
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 33
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 37
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 37
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 47
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
]
