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
  id 1526
  arrival_time 33818.053331957424
  lifetime 353.7846756001687
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 0
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 26
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 23
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 12
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 26
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
]
