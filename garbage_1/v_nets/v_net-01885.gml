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
  id 1885
  arrival_time 41523.610459760566
  lifetime 959.2011824012362
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 21
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 2
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 41
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 8
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 18
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 11
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 11
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 16
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 10
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 39
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
]
