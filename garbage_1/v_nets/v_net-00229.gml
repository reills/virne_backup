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
  id 229
  arrival_time 4201.01031320007
  lifetime 481.1854447456751
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 44
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 11
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 32
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 6
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 23
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 34
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 31
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 9
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 0
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 20
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 15
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 8
    rom 40
  ]
  node [
    id 12
    label "12"
    cpu 13
    gpu 20
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
