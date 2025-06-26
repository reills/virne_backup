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
  id 1679
  arrival_time 37367.19272973527
  lifetime 1887.0701101443
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 28
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 16
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 41
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 26
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 10
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
]
