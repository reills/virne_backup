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
  id 1118
  arrival_time 23278.220417082925
  lifetime 1960.941810077538
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 35
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 41
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 9
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 7
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 45
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 39
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 20
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 30
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 32
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
]
