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
  id 1502
  arrival_time 33355.2903849215
  lifetime 2472.3758978344513
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 40
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 32
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
]
