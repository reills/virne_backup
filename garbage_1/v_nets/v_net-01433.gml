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
  id 1433
  arrival_time 30027.02257407705
  lifetime 412.63558877545586
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 0
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 1
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 6
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 34
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
]
