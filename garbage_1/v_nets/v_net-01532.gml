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
  id 1532
  arrival_time 33855.81857929556
  lifetime 1986.4250148107253
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 29
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 50
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 48
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 47
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]
