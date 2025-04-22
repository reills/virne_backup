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
  id 148
  arrival_time 2645.382485718845
  lifetime 283.2608556763475
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 33
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 1
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 32
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 2
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
]
