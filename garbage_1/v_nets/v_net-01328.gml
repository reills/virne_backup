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
  id 1328
  arrival_time 27926.73754472767
  lifetime 1216.8400975054813
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 24
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 17
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 13
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 8
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 33
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 27
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 10
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
]
