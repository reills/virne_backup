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
  id 222
  arrival_time 4076.664573043346
  lifetime 168.48378294763342
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 11
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 45
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 43
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 9
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
]
