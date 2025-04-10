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
  id 1647
  arrival_time 36762.018987555864
  lifetime 516.2840380236163
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 0
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 47
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
]
