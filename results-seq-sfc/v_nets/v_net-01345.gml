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
  id 1345
  arrival_time 28439.504442907582
  lifetime 2446.5532814882076
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 31
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 17
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
]
