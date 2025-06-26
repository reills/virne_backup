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
  id 838
  arrival_time 17363.562538976537
  lifetime 401.95388987525956
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 46
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 23
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 44
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 14
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 14
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
]
