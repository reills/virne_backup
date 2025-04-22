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
  id 1795
  arrival_time 39860.77872927296
  lifetime 837.8743894836036
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 45
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 21
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 45
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 36
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
]
