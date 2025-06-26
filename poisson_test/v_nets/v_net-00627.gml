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
  id 627
  arrival_time 12895.945288807843
  lifetime 93.0288080914803
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 9
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 28
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 33
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 27
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
]
