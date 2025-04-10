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
  id 866
  arrival_time 18082.582403238044
  lifetime 36.95836823457863
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 3
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 3
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 26
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 33
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 37
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 19
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 11
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 0
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
]
