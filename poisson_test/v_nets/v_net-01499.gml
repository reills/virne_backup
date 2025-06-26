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
  id 1499
  arrival_time 33340.60613864921
  lifetime 1017.66944975559
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 15
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 28
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 2
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
]
