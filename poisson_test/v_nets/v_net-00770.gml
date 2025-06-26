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
  id 770
  arrival_time 16102.059338063751
  lifetime 327.79826939322857
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 35
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 44
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 25
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 18
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 11
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 41
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 21
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 0
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 33
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 0
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 28
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 35
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 8
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
]
