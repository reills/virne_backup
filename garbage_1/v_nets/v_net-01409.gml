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
  id 1409
  arrival_time 29491.73037182797
  lifetime 142.3105110815275
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 36
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 10
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 36
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
]
