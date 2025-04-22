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
  id 371
  arrival_time 7020.036597689685
  lifetime 444.48514265667296
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 21
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 44
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 20
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 32
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 50
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 6
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
]
