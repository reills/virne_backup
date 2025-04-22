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
  id 1980
  arrival_time 43334.38637889795
  lifetime 1199.7077731771312
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 50
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 34
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 48
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 5
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 10
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 9
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 5
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 21
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 8
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 42
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
]
