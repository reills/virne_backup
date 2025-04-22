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
  id 1941
  arrival_time 42781.5417738636
  lifetime 401.69158586006233
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 39
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 41
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 33
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 43
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 14
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 0
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 16
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
]
