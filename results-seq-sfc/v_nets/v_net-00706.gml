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
  id 706
  arrival_time 14823.401442642455
  lifetime 91.5026704192223
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 30
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 14
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 48
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 41
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 48
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 47
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 18
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
]
