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
  id 517
  arrival_time 9861.523784123834
  lifetime 846.2565347825802
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 12
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 22
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 15
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 50
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 25
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 50
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
]
