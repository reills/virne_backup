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
  id 1298
  arrival_time 27100.84986252033
  lifetime 1067.98699902591
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 27
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 43
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 30
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 39
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 27
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 38
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
]
