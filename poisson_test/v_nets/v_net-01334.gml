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
  id 1334
  arrival_time 28090.618227964445
  lifetime 139.9139886132685
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 25
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 25
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 18
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
]
