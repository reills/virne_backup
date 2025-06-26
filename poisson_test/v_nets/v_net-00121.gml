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
  id 121
  arrival_time 2158.269461116718
  lifetime 471.2664211264155
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 8
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 41
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
]
