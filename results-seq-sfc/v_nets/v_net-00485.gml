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
  id 485
  arrival_time 8949.169914932403
  lifetime 1665.249956989769
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 0
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 42
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 33
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 33
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 44
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 41
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 2
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
]
