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
  id 565
  arrival_time 10701.612280362448
  lifetime 2358.7848740980344
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 39
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 6
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
]
