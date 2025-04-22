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
  id 347
  arrival_time 6604.262320476139
  lifetime 330.4393420914472
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 13
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 26
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 21
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 42
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 13
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
]
