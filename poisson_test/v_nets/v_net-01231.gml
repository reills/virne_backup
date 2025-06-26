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
  id 1231
  arrival_time 25439.88000570234
  lifetime 71.17733063154192
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 21
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 7
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 49
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 32
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 11
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 6
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 42
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 19
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 2
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 45
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 34
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 42
    rom 2
  ]
  node [
    id 12
    label "12"
    cpu 1
    gpu 15
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 47
    gpu 22
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 34
  ]
]
