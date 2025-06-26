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
  id 498
  arrival_time 9412.455231905236
  lifetime 1595.423303178671
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 46
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 23
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 8
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 12
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 12
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 14
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 14
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 31
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 17
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 27
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 44
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 1
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
]
