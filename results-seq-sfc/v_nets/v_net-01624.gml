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
  id 1624
  arrival_time 36331.17789694121
  lifetime 37.94860896348499
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 37
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 39
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 33
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 37
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 38
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 47
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 48
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 19
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 46
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 3
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
]
