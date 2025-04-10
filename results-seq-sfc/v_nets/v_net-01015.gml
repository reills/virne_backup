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
  id 1015
  arrival_time 21636.089273093166
  lifetime 814.1482845478148
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 44
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 19
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 25
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 36
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 3
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 5
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 5
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 3
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
]
