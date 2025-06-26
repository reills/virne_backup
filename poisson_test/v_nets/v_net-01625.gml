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
  id 1625
  arrival_time 36339.37994435805
  lifetime 602.5567526919641
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 10
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 50
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 33
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 42
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
]
