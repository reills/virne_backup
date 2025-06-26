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
  id 247
  arrival_time 4748.619346047674
  lifetime 325.5679197694962
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 25
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 36
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
]
