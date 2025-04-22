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
  id 1287
  arrival_time 26819.120080397115
  lifetime 259.6569470211157
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 39
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 12
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 15
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 13
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
]
