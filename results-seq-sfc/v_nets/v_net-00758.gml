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
  id 758
  arrival_time 15989.635742094855
  lifetime 967.7021177141061
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 43
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 33
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 26
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 21
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 48
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 28
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 14
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 36
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
]
