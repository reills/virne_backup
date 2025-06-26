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
  id 1136
  arrival_time 23648.300057741864
  lifetime 695.0548922827174
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 32
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 45
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 9
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 39
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 44
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 28
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 34
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 26
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 5
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 37
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 45
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
]
