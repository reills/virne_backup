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
  id 583
  arrival_time 10945.737439205412
  lifetime 28.347494458841226
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 40
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 41
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 16
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 7
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 10
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 46
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
]
