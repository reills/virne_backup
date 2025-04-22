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
  id 437
  arrival_time 8422.814111627915
  lifetime 104.38321028366455
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 28
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 50
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
]
