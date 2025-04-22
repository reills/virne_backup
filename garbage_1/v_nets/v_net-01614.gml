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
  id 1614
  arrival_time 36098.57524553826
  lifetime 276.87033325470645
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 44
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 42
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 18
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
]
