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
  id 766
  arrival_time 16069.001043891116
  lifetime 2271.172161591575
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 49
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 6
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 41
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 48
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 32
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 10
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
]
