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
  id 286
  arrival_time 5551.276266355992
  lifetime 558.8779394041776
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 31
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 8
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 20
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 34
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 23
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 37
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 13
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 21
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 28
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 15
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 18
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 37
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 0
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 33
    gpu 22
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
]
