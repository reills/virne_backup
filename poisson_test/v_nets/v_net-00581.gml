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
  id 581
  arrival_time 10917.283081785003
  lifetime 988.0264034222415
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 33
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 18
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 48
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 39
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
]
