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
  id 1211
  arrival_time 25224.741552221847
  lifetime 1507.4792351999376
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 33
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 10
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 10
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 36
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 49
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 5
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 1
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 36
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 34
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
]
