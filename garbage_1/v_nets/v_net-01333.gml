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
  id 1333
  arrival_time 28084.819650804493
  lifetime 485.47022000495934
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 48
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 37
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 18
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 21
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 1
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
]
