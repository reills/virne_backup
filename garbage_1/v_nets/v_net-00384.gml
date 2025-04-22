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
  id 384
  arrival_time 7624.7549561716
  lifetime 2343.7410619736143
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 35
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 2
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 4
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 27
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 3
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
]
