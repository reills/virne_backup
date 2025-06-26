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
  id 740
  arrival_time 15534.117225495387
  lifetime 1597.2828076825756
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 45
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 6
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 9
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
]
