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
  id 537
  arrival_time 10217.128871025367
  lifetime 148.23555375705664
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 36
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 25
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 5
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 15
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 45
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 50
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
]
