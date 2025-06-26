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
  id 745
  arrival_time 15761.552763831885
  lifetime 1175.74718500038
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 6
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 37
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 39
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 13
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 4
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 2
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 25
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 17
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 23
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
]
