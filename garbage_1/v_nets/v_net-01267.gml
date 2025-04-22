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
  id 1267
  arrival_time 26614.76759381878
  lifetime 511.0315598471201
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 26
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 27
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 30
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 38
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 41
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 11
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 35
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 12
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 50
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
]
