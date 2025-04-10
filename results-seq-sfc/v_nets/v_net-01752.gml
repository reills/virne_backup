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
  id 1752
  arrival_time 39059.557593660706
  lifetime 1471.2372766424307
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 30
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 39
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 14
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
]
