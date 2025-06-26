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
  id 1988
  arrival_time 43394.253395081294
  lifetime 393.32436839054884
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 8
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 19
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 38
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 9
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
]
