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
  id 1312
  arrival_time 27482.53864146322
  lifetime 646.949092810285
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 43
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 19
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 32
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 11
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 2
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 33
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 22
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 42
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 38
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 35
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
]
