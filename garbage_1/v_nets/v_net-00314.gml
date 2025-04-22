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
  id 314
  arrival_time 5846.311692385819
  lifetime 1372.2530746892926
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 9
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 31
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 46
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
]
