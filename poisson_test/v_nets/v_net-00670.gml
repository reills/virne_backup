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
  id 670
  arrival_time 14309.817711373416
  lifetime 1266.2980140326913
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 40
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 36
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 25
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 27
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
]
