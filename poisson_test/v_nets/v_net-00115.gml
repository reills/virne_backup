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
  id 115
  arrival_time 2143.8444974542144
  lifetime 89.42108409308143
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 29
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 27
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 21
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 29
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 41
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 10
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
]
