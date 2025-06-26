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
  id 1456
  arrival_time 30620.51907040388
  lifetime 545.1998681700973
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 14
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 38
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 9
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 26
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 19
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 28
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 14
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 23
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
]
