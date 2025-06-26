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
  id 1576
  arrival_time 35151.70801423432
  lifetime 161.62788406629195
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 22
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 12
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 3
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
]
