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
  id 1177
  arrival_time 24378.82131307635
  lifetime 2284.1920739287693
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 37
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 47
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 34
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 44
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 39
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
]
