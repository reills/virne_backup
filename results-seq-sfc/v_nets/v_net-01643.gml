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
  id 1643
  arrival_time 36711.41667142511
  lifetime 1877.5805079461504
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 44
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 29
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 49
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 21
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 7
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
]
