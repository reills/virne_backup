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
  id 84
  arrival_time 1661.0163159520794
  lifetime 1051.6053575655753
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 1
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 32
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
]
