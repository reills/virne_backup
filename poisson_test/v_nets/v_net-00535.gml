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
  id 535
  arrival_time 10167.07039668575
  lifetime 50.23497895678307
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 1
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 30
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 34
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 36
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 37
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 31
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 49
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 4
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 22
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 18
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 46
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
]
