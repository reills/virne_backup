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
  id 1056
  arrival_time 22252.56264239741
  lifetime 2094.6769450003358
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 50
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 10
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 47
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 34
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 39
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 4
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
]
