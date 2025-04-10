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
  id 436
  arrival_time 8422.258365180878
  lifetime 86.29073614628244
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 3
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 7
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
]
