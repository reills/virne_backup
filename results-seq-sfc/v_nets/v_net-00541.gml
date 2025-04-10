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
  id 541
  arrival_time 10258.743487946816
  lifetime 3024.6345623548204
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 38
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 43
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 49
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 4
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 31
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 13
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
  edge [
    source 3
    target 4
    bw 7
  ]
]
