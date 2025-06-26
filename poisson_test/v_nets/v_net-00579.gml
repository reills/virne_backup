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
  id 579
  arrival_time 10828.238909725453
  lifetime 1146.612683479054
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 14
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 20
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 28
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
]
