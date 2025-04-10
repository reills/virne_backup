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
  id 1418
  arrival_time 29660.92010739154
  lifetime 1635.3849102786787
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 15
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 30
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 13
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 22
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
]
