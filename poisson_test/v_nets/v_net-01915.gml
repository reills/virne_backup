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
  id 1915
  arrival_time 42074.02941915733
  lifetime 427.1576529587087
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 25
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 39
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 38
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 27
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
]
