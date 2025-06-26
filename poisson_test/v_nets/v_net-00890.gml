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
  id 890
  arrival_time 18826.092496301546
  lifetime 453.3486293372863
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 29
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 32
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 41
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 25
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
]
