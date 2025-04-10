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
  id 456
  arrival_time 8664.020294353759
  lifetime 1532.3347541595674
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 12
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 50
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 2
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 30
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
]
