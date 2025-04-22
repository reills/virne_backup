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
  id 411
  arrival_time 8101.412709305421
  lifetime 399.04396943643223
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 33
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 21
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 28
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 8
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 42
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 23
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 12
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
]
