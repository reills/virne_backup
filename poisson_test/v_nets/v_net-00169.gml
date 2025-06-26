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
  id 169
  arrival_time 3200.2894147263014
  lifetime 253.96887733093854
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 11
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 25
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 28
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 46
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 22
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 34
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 17
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 48
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 0
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 28
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 46
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
]
