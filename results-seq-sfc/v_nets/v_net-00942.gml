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
  id 942
  arrival_time 20109.682006321884
  lifetime 3048.6093776407956
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 29
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 29
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 15
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 16
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 35
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 46
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
]
