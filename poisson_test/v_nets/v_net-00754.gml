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
  id 754
  arrival_time 15932.428726409107
  lifetime 999.279304490465
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 44
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 19
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 24
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
]
