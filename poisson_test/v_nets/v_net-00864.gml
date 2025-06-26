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
  id 864
  arrival_time 18067.485867254185
  lifetime 3391.462386294816
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 18
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 50
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 20
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
]
