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
  id 1325
  arrival_time 27878.11676255457
  lifetime 1392.3461718019255
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 25
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 30
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 11
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 42
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
]
