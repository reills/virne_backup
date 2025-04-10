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
  id 38
  arrival_time 659.5644708011155
  lifetime 1292.3405355660416
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 25
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 47
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 4
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 11
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
]
