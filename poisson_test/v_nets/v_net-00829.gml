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
  id 829
  arrival_time 17110.257954413297
  lifetime 884.0890887470216
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 31
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 20
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 14
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 48
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 11
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 24
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 33
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 14
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 12
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 2
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 29
    gpu 28
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 20
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 36
    rom 8
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 3
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
  edge [
    source 12
    target 13
    bw 47
  ]
]
