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
  id 1416
  arrival_time 29650.157649125682
  lifetime 261.05686184643014
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 1
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 47
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 44
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 48
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 18
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
]
