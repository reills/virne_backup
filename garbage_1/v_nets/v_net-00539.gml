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
  id 539
  arrival_time 10246.198138708505
  lifetime 2404.362491629349
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 21
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 28
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 6
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
]
