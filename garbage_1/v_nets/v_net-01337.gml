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
  id 1337
  arrival_time 28378.090227690212
  lifetime 1814.4660561631397
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 46
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 46
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 25
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 42
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 35
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 48
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 27
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 3
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 31
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 50
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
]
