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
  id 1948
  arrival_time 42803.52590764806
  lifetime 580.3391642338532
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 15
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 45
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 14
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 37
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 41
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
]
