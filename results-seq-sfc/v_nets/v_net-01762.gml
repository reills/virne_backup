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
  id 1762
  arrival_time 39405.84192294178
  lifetime 496.29363182431575
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 13
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 10
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 40
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 0
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 30
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
]
