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
  id 571
  arrival_time 10738.48436943111
  lifetime 1376.8473326966712
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 30
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 12
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 35
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 1
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 46
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 27
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 24
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 0
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 50
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
]
