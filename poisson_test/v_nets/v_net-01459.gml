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
  id 1459
  arrival_time 30626.27489093748
  lifetime 397.6516679287499
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 31
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 31
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
]
