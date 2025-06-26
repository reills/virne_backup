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
  id 1291
  arrival_time 27051.659730551226
  lifetime 746.3640458726834
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 36
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 44
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 4
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 31
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 12
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 19
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 9
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
]
