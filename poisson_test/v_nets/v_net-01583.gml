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
  id 1583
  arrival_time 35731.48689122131
  lifetime 1182.407339459064
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 50
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 46
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
]
