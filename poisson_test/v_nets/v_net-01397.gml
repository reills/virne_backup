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
  id 1397
  arrival_time 29370.156900410853
  lifetime 609.2587246386177
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 33
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 8
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 23
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 41
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 15
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 12
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
]
