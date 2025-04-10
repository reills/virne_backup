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
  id 1918
  arrival_time 42106.57367448252
  lifetime 129.16257845209276
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 20
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 27
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 47
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
]
