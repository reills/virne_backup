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
  id 1877
  arrival_time 41398.69041451453
  lifetime 345.93760940397186
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 1
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 27
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 50
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 30
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 11
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
]
