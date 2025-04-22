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
  id 1839
  arrival_time 40617.696543692866
  lifetime 428.52068029515755
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 13
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 11
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 0
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 6
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 21
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 38
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 49
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 12
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 8
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
]
