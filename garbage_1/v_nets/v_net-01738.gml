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
  id 1738
  arrival_time 38810.66779620568
  lifetime 766.5995305591385
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 19
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 13
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 45
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 37
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 27
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 25
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 6
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 37
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 6
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 3
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 19
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 14
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 18
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]
