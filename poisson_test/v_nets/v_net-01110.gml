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
  id 1110
  arrival_time 23175.950068692422
  lifetime 2053.921113133111
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 15
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 27
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 38
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 45
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 4
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 17
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 29
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 44
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
]
