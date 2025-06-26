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
  id 676
  arrival_time 14368.325658109352
  lifetime 1142.0392155518186
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 14
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 31
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 46
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 30
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 7
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 10
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
]
