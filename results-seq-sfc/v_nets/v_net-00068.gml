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
  id 68
  arrival_time 1274.3132078951187
  lifetime 616.8403679787388
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 49
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 27
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
]
