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
  id 1545
  arrival_time 34160.31269094165
  lifetime 1508.6288967577207
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 32
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 36
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 34
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 43
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 0
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
]
