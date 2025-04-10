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
  id 1716
  arrival_time 38246.255120024005
  lifetime 1130.770839549818
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 29
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 48
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 40
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 14
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 26
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 21
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 38
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
