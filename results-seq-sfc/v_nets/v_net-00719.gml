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
  id 719
  arrival_time 15043.26318226207
  lifetime 91.10760824601606
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 41
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 6
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 11
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 10
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
]
