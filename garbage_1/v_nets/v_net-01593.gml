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
  id 1593
  arrival_time 35832.034959523735
  lifetime 716.190756065407
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 0
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 7
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 37
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 46
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 1
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
]
