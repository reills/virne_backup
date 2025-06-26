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
  id 395
  arrival_time 7829.3027444372365
  lifetime 1856.3822679911439
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 4
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 36
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 21
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
]
