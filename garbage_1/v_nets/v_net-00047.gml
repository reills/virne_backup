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
  id 47
  arrival_time 968.9265765942891
  lifetime 1213.9603570364297
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 49
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 49
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 44
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
]
