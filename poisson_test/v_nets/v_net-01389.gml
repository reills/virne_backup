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
  id 1389
  arrival_time 29328.77737599438
  lifetime 1227.7379324035173
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 12
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 6
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 43
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
]
