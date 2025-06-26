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
  id 327
  arrival_time 6303.223850731741
  lifetime 1153.7613632919504
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 15
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 6
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 2
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
]
