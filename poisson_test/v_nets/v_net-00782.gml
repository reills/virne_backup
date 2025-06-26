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
  id 782
  arrival_time 16183.431615748239
  lifetime 399.58022583504084
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 28
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 40
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 4
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 12
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 43
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 21
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 19
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 28
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 37
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 28
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
]
