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
  id 1466
  arrival_time 30718.52316794478
  lifetime 361.3293587965116
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 43
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 35
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 39
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 24
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 45
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
]
