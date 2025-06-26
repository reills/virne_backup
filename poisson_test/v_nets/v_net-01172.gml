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
  id 1172
  arrival_time 24342.64836071806
  lifetime 1289.4332933577716
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 19
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 40
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 27
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 19
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 21
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
]
