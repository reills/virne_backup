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
  id 968
  arrival_time 20521.53558133873
  lifetime 1031.7270425710303
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 6
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 2
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 8
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 46
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
]
