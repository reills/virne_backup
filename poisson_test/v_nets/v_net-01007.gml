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
  id 1007
  arrival_time 21533.356027581685
  lifetime 970.4624363507943
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 8
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 47
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 45
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 41
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 8
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
]
