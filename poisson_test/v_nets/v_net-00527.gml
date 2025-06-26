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
  id 527
  arrival_time 10085.705874647207
  lifetime 823.921294963452
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 35
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 5
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 3
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 47
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 46
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
]
