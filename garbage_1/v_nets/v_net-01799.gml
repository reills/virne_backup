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
  id 1799
  arrival_time 39945.30467249336
  lifetime 598.3419730137996
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 21
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 0
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 32
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 28
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
]
