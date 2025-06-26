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
  id 1396
  arrival_time 29362.394160165568
  lifetime 1537.3073928506876
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 27
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 13
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
]
