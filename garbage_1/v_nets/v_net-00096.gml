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
  id 96
  arrival_time 1938.6476696550415
  lifetime 15.840167704284935
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 28
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 41
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 34
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
]
