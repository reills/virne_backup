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
  id 1441
  arrival_time 30239.59411693031
  lifetime 1573.9305569866494
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 3
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 35
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 1
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 43
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 3
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 8
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 29
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 7
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 26
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 43
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
]
