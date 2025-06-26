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
  id 707
  arrival_time 14828.986861556223
  lifetime 355.22358308952147
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 33
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 41
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 14
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 11
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 41
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 9
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 15
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 31
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 24
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 48
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
]
