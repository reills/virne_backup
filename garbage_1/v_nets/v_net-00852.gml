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
  id 852
  arrival_time 17613.953240124036
  lifetime 142.5933452225673
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 33
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 44
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 7
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 36
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 20
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 31
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
]
