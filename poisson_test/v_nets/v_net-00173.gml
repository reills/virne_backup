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
  id 173
  arrival_time 3289.8278044279828
  lifetime 600.6645524379743
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 45
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 19
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
]
