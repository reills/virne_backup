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
  id 1175
  arrival_time 24365.20092939451
  lifetime 1147.4100910504258
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 34
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 48
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 25
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 13
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
]
