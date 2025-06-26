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
  id 789
  arrival_time 16257.368266406344
  lifetime 1919.2760162386533
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 24
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 39
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 42
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
]
