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
  id 1787
  arrival_time 39818.72813290933
  lifetime 3301.6071087863766
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 35
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 4
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
]
