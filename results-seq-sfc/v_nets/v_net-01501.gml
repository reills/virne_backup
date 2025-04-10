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
  id 1501
  arrival_time 33353.80665705392
  lifetime 596.7589821057354
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 30
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 48
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 34
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 45
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
]
